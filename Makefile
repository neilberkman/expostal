PRIV_DIR = $(MIX_APP_PATH)/priv
NIF_SO = $(PRIV_DIR)/expostal.so

# Compiler flags
CFLAGS += -O3 -std=gnu99 -fPIC -Wall -Wextra -Wno-unused-parameter -Wno-unused-function

# Erlang/OTP includes
ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS += -I$(ERLANG_PATH)

# libpostal prefix (override with LIBPOSTAL_PREFIX=/path)
LIBPOSTAL_PREFIX ?= /usr/local
CFLAGS += -I$(LIBPOSTAL_PREFIX)/include

# Platform-specific shared library flags
ifeq ($(shell uname),Darwin)
	LDFLAGS_SHARED = -dynamiclib -undefined dynamic_lookup
else
	LDFLAGS_SHARED = -shared
endif

# Static vs dynamic linking
# Set LIBPOSTAL_STATIC=1 for static linking (Docker builds)
ifdef LIBPOSTAL_STATIC
	LIBPOSTAL_LIB = $(LIBPOSTAL_PREFIX)/lib/libpostal.a
	LDFLAGS += $(LDFLAGS_SHARED) -lstdc++ -lm
else
	LIBPOSTAL_LIB =
	LDFLAGS += $(LDFLAGS_SHARED) -L$(LIBPOSTAL_PREFIX)/lib -lpostal
endif

.PHONY: all clean

all: $(NIF_SO)

$(PRIV_DIR):
	mkdir -p $@

$(NIF_SO): $(PRIV_DIR) src/expostal.c
ifdef LIBPOSTAL_STATIC
	$(CC) $(CFLAGS) -o $@ src/expostal.c $(LIBPOSTAL_LIB) $(LDFLAGS)
else
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ src/expostal.c
endif

clean:
	$(RM) $(NIF_SO)
