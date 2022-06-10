APP := app
VENV := venv
PYTHON := ${VENV}/bin/python
PIP := ${VENV}/bin/pip
DOCKERFILE := Dockerfile

.PHONY: all install run lint test format clean

all: install lint test format

${VENV}/bin/activate: requirements-dev.txt
	python3 -m venv ${VENV}
	${PIP} install --upgrade pip
	${PIP} install -r requirements-dev.txt

install: ${VENV}/bin/activate

run: install
	${PYTHON} ${APP}.py

lint: install
	docker run --rm -i hadolint/hadolint < ${DOCKERFILE}
	${PYTHON} -m pylint --disable=C *.py

test: install
	${PYTHON} -m pytest --cov=${APP}

format: install
	${PYTHON} -m black *.py

clean:
	rm -rf ${VENV}
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -f .coverage
