# Expostal application Dockerfile with statically linked libpostal
#
# Requires the libpostal base image to be built first:
#   docker build -f Dockerfile.libpostal-base -t libpostal-base:1.1 .
#
# Build:
#   docker build -t expostal-app .
#
# Run:
#   docker run --rm expostal-app bin/YOUR_APP eval 'Expostal.parse("123 Main St")'

ARG LIBPOSTAL_IMAGE=libpostal-base:1.1
FROM ${LIBPOSTAL_IMAGE} AS libpostal

# Build stage
FROM hexpm/elixir:1.18-erlang-26.2.2-debian-bookworm-20251229-slim AS builder

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy libpostal static lib and headers from base image
COPY --from=libpostal /usr/local/lib/libpostal.a /usr/local/lib/
COPY --from=libpostal /usr/local/include/libpostal /usr/local/include/libpostal

WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && mix local.rebar --force

# Set build environment
ENV MIX_ENV=prod
ENV LIBPOSTAL_STATIC=1

# Install dependencies first (cached layer)
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
RUN mix deps.compile

# Copy application source
COPY lib lib
COPY src src
COPY Makefile ./
COPY config config

# Compile NIF and application
RUN mix compile

# Build release (uncomment and customize for your app)
# COPY rel rel
# RUN mix release

# Runtime stage - use Elixir image for testing, or debian-slim for production releases
FROM hexpm/elixir:1.18-erlang-26.2.2-debian-bookworm-20251229-slim AS runtime


# Copy libpostal data from base image
COPY --from=libpostal /data /data
ENV LIBPOSTAL_DATA_DIR=/data/libpostal

WORKDIR /app

# Copy compiled application (for library testing)
COPY --from=builder /app/_build/prod /app/_build/prod
COPY --from=builder /app/deps /app/deps
COPY --from=builder /app/mix.exs /app/mix.exs
COPY --from=builder /app/mix.lock /app/mix.lock
COPY --from=builder /app/lib /app/lib
COPY --from=builder /root/.mix /root/.mix

ENV HOME=/root
ENV MIX_ENV=prod

# Default command for testing the NIF (using elixir directly to avoid mix recompilation)
CMD ["elixir", "-pa", "_build/prod/lib/expostal/ebin", "-e", "IO.inspect(Expostal.parse_address(\"123 Main St, New York, NY 10001\"))"]
