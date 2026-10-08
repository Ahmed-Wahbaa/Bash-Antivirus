DIR ?= safe_dir
MALICIOUS_DIR ?= safe_malicious
INTERVAL ?= 5
.PHONY: daemon restore clean
prepare:
	mkdir -p $(DIR) $(MALICIOUS_DIR)
daemon: prepare
	bash antivirusd.sh $(DIR) $(MALICIOUS_DIR) $(INTERVAL)
restore: prepare
	bash restore.sh $(DIR) $(MALICIOUS_DIR)
clean:
	rm -f directory-info.last directory-info.new
