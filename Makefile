.PHONY: help install serve build llms check clean

help:
	@echo "make install  - create .venv and install requirements"
	@echo "make serve    - local preview (Zensical prints the exact URL)"
	@echo "make build    - strict production build into site/"
	@echo "make llms     - regenerate docs/llms.txt and docs/llms-full.txt"
	@echo "make check    - regenerate/check the AI index and build strictly"
	@echo "make clean    - remove site/ and caches"

install:
	python3 -m venv .venv
	.venv/bin/pip install -r requirements.txt

serve:
	.venv/bin/zensical serve

build:
	.venv/bin/zensical build --strict

llms:
	.venv/bin/python scripts/gen_llms_txt.py

check: llms
	.venv/bin/zensical build --strict

clean:
	rm -rf site .cache
	find docs -name '__pycache__' -type d -prune -exec rm -rf {} +
