PRIV_DIR = $(MIX_APP_PATH)/priv
NIF_SO = $(PRIV_DIR)/expostal.so

# Compiler flags
CFLAGS += -O3 -std=gnu99 -fPIC -Wall -Wextra -Wno-unused-parameter -Wno-unused-function

# Erlang/OTP includes
ERLANG_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CFLAGS += -I$(ERLANG_PATH)

# libpostal library
CFLAGS += -I/usr/local/include -I/usr/include
LDFLAGS += -L/usr/local/lib -L/usr/lib -lpostal

# Platform-specific flags
ifeq ($(shell uname),Darwin)
	LDFLAGS += -dynamiclib -undefined dynamic_lookup
else
	LDFLAGS += -shared
endif

.PHONY: all clean

all: $(NIF_SO)

$(PRIV_DIR):
	mkdir -p $@

$(NIF_SO): $(PRIV_DIR) src/expostal.c
	$(CC) $(CFLAGS) -shared $(LDFLAGS) -o $@ src/expostal.c

clean:
	$(RM) $(NIF_SO)
