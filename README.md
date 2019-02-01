React app Headless Browser Automation & Testing with Selenium ChromeDriver and Pytest.

## Quick Start:

### Clone SeleniumBase from GitHub:

`git clone https://github.com/seleniumbase/SeleniumBase.git`

### Install npm dependencies:

`npm install`

### Install SeleniumBase:

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

### Docker

```
docker build --no-cache -t e2e-test .

docker run -p 80:80 --rm e2e-test
```

### Circleci

CI Config is in `.circleci/config.yml`
