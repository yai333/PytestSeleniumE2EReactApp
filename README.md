React app Headless Browser Automation & Testing with Selenium ChromeDriver and Pytest.
https://medium.com/@yia333/in-order-to-create-automated-testing-in-a-continuous-integration-environment-you-will-need-to-35d9952ccca4

## Quick Start:

### Clone SeleniumBase from GitHub:

`git clone https://github.com/seleniumbase/SeleniumBase.git`

### Install npm dependencies:

`npm install`

### Install Python dependencies:

```
cd pytest
pip install -U -r requirements.txt
```

### Run a test on Chrome:

```
npm start
cd pytest
pytest --url http://localhost:3000 -s
```

### Run with Docker

```
docker build --no-cache -t e2e-test .

docker run -p 80:80 --rm e2e-test
```

### Run with CircleCI

CI Config is in `.circleci/config.yml`
