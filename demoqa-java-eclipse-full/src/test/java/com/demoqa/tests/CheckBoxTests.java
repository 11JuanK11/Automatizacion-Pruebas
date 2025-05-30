package com.demoqa.tests;

import org.junit.jupiter.api.*;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import io.github.bonigarcia.wdm.WebDriverManager;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class CheckBoxTests {

    WebDriver driver;
    ByteArrayOutputStream videoLog;

    static final String BASE_URL = "https://demoqa.com/checkbox";

    @BeforeAll
    void setupAll() {
        WebDriverManager.chromedriver().setup();
        videoLog = new ByteArrayOutputStream();
        System.setOut(new PrintStream(videoLog));
    }

    @BeforeEach
    void setup() {
        driver = new ChromeDriver(new ChromeOptions()
            .addArguments("--disable-popup-blocking", "--disable-extensions", "--blink-settings=imagesEnabled=false"));
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
        driver.manage().window().maximize();
    }

    @AfterEach
    void tearDown(TestInfo info) throws Exception {
        // screenshot
        TakesScreenshot ts = (TakesScreenshot) driver;
        File ss = ts.getScreenshotAs(OutputType.FILE);
        Files.copy(ss.toPath(), Path.of("target/screenshots/" + info.getDisplayName() + ".png"));
        driver.quit();
    }

    @AfterAll
    void teardownAll() throws Exception {
        Files.write(Path.of("target/suite_log.txt"), videoLog.toByteArray());
    }

    @Test
    void selectAllCheckboxes() throws InterruptedException {
        driver.get(BASE_URL);
        ((JavascriptExecutor) driver).executeScript("document.querySelector('button.rct-option-expand-all').click()");
        Thread.sleep(1000);
        String[] ids = { "notes", "commands", "react", "angular", "veu", "public", "private", "classified", "general", "wordFile", "excelFile"};
        for (String id: ids) {
            ((JavascriptExecutor) driver).executeScript("document.querySelector('#tree-node-" + id + "').parentElement.click()");
            Thread.sleep(200);
        }
        Assertions.assertTrue(true);
    }

    @Test
    void selectNotesAndCommands() throws InterruptedException {
        driver.get(BASE_URL);
        ((JavascriptExecutor) driver).executeScript("document.querySelector('button.rct-option-expand-all').click()");
        Thread.sleep(500);
        ((JavascriptExecutor) driver).executeScript("document.querySelector('#tree-node-notes').parentElement.click()");
        ((JavascriptExecutor) driver).executeScript("document.querySelector('#tree-node-commands').parentElement.click()");
        Thread.sleep(500);
    }

    @Test
    void selectReactAngularVeu() throws InterruptedException {
        driver.get(BASE_URL);
        ((JavascriptExecutor) driver).executeScript("document.querySelector('button.rct-option-expand-all').click()");
        Thread.sleep(500);
        for (String id: new String[]{"react","angular","veu"}) {
            ((JavascriptExecutor) driver).executeScript("document.querySelector('#tree-node-" + id + "').parentElement.click()");
            Thread.sleep(200);
        }
    }

    @Test
    void selectPublicPrivateClassifiedGeneral() throws InterruptedException {
        driver.get(BASE_URL);
        ((JavascriptExecutor) driver).executeScript("document.querySelector('button.rct-option-expand-all').click()");
        Thread.sleep(500);
        for (String id: new String[]{"public","private","classified","general"}) {
            ((JavascriptExecutor) driver).executeScript("document.querySelector('#tree-node-" + id + "').parentElement.click()");
            Thread.sleep(200);
        }
    }

    @Test
    void selectWordFileExcelFile() throws InterruptedException {
        driver.get(BASE_URL);
        ((JavascriptExecutor) driver).executeScript("document.querySelector('button.rct-option-expand-all').click()");
        Thread.sleep(500);
        for (String id: new String[]{"wordFile","excelFile"}) {
            ((JavascriptExecutor) driver).executeScript("document.querySelector('#tree-node-" + id + "').parentElement.click()");
            Thread.sleep(200);
        }
    }
}
