TESTS = test/*.js
REPORTER = spec
TIMEOUT = 20000
ISTANBUL = ./node_modules/.bin/istanbul
MOCHA = ./node_modules/mocha/bin/_mocha
COVERALLS = ./node_modules/coveralls/bin/coveralls.js

test:
	@NODE_ENV=test $(MOCHA) -R $(REPORTER) --timeout $(TIMEOUT) \
		$(MOCHA_OPTS) \
		$(TESTS)

test-cov:
	@$(ISTANBUL) cover --report html $(MOCHA) -- -R spec $(TESTS)

test-coveralls: test-cov
	@echo TRAVIS_JOB_ID $(TRAVIS_JOB_ID)
	@cat ./coverage/lcov.info | $(COVERALLS) && rm -rf ./coverage

test-all: test test-coveralls

.PHONY: test
