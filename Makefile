.PHONY: fetch-profiles venv clean

venv:
	pipenv sync

fetch-profiles: venv
	pipenv run bash scripts/shell/fetch_profiles.sh $(INPUT_FILE) $(OUTPUT_FILE)

clean:
	pipenv --rm 2>/dev/null || true
	@echo "✓ Virtual environment cleaned"
