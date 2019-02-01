import pytest
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys

@pytest.fixture(scope="module")
def open_url(browser,url):
    browser.get(url)
    browser.find_element(By.TAG_NAME, "form")
    assert browser.title == "React App"

def test_add_todo(browser, open_url):
    todoText = "Add to do item 1 by PYTEST"
    newItemAdded = False
    originItemsCount = len(browser.find_elements(By.XPATH, '//*[@class="todo"]'))
    browser.find_element_by_name('addToDo').send_keys(todoText)
    browser.find_element_by_name('addToDo').send_keys(Keys.ENTER)
    updatedList = browser.find_elements(By.XPATH, '//*[@class="todo"]')
    assert len(updatedList) == originItemsCount+1
    for item in updatedList:
        if item.text.find(todoText):
            newItemAdded = True

    assert newItemAdded == True

def test_complete_todo(browser, open_url):
    browser.find_element_by_name('btnComplete').click()
    assert browser.find_element(By.XPATH, '//*[@class="todo"]').get_attribute('style') == 'text-decoration: line-through;'

def test_remove_todo(browser, open_url):
    originItemsCount = len(browser.find_elements(By.XPATH, '//*[@class="todo"]'))
    browser.find_element_by_name('btnDelete').click()
    newItemCount = len(browser.find_elements(By.XPATH, '//*[@class="todo"]'))
    assert newItemCount == originItemsCount-1

def test_teardown(browser):
    browser.close()
    browser.quit()
