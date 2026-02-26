# Amazon Cheapest Vacuum Test

End-to-end UI automation test built with Robot Framework + SeleniumLibrary and a custom Python validation library to verify Amazon search, price sorting, and add-to-cart behavior.

## Project Structure
- `tests/` - Robot test suites (`amazon_vacuum_test.robot`) containing the test scenario.
- `resources/` - Reusable keywords and page locators (`amazon_keywords.resource`, `common.resource`).
- `libraries/` - Custom Python library (`AmazonValidationLib.py`) for price-order validation.
- `results/` - Generated execution artifacts (`log.html`, `report.html`, `output.xml`, screenshots).

The project follows a POM-style separation: UI locators and interaction keywords are centralized in resource files, while assertions/business validation logic is isolated in a Python library.

## Requirements
- Python 3.x
- Google Chrome browser
- Robot Framework
- Robot Framework SeleniumLibrary

Install dependencies:
```bash
pip install -r requirements.txt
```

## Run Test
Execute from repository root:
```bash
robot -d results tests/amazon_vacuum_test.robot
```

Open generated reports:
- `results/report.html`
- `results/log.html`

## Engineering Highlights
- Custom Python validator (`AmazonValidationLib.py`) converts price strings to numeric values and performs ascending-order checks.
- Search-result price validation excludes `Sponsored` cards and items without add-to-cart availability to improve stability.
- Locators prioritize resilient selectors (semantic IDs, stable attributes, constrained XPath/CSS) instead of volatile dynamic framework IDs.
