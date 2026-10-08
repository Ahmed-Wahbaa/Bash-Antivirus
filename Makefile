DIR ?= safe_dir
MALICIOUS_DIR ?= safe_malicious
INTERVAL ?= 5
.PHONY: daemon restore clean
daemon:
	bash antivirusd.sh $(DIR) $(MALICIOUS_DIR) $(INTERVAL)
restore:
	bash restore.sh $(DIR) $(MALICIOUS_DIR)
clean:
	rm -f directory-info.last directory-info.new
