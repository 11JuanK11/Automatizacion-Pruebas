package com.demoqa.tests;

import org.junit.jupiter.api.*;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import io.github.bonigarcia.wdm.WebDriverManager;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.util.*;
import java.util.stream.Collectors;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class WebTablesTest {

    WebDriver driver;
    ByteArrayOutputStream videoLog;

    static final String BASE_URL = "https://demoqa.com/webtables";

    @BeforeAll
    void setupAll() {
        WebDriverManager.chromedriver().setup();
        videoLog = new ByteArrayOutputStream();
        System.setOut(new PrintStream(videoLog));
    }

    @BeforeEach
    void setup() {
        driver = new ChromeDriver();
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
        driver.manage().window().maximize();
        // Eliminar anuncios
        //((JavascriptExecutor) driver).executeScript("window.open('about:blank','_blank').close();");
       // ((JavascriptExecutor) driver).executeScript("document.querySelectorAll('iframe, .ad, .ads, [id*="google_ads"]').forEach(e => e.remove());");
       // ((JavascriptExecutor) driver).executeScript("document.body.style.zoom = '0.8';");
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

    @TestFactory
    Collection<DynamicTest> tableTests() throws Exception {
        List<String> lines = Files.readAllLines(Path.of("src/test/resources/web_tables_data.csv"));
        lines.remove(0);
        return lines.stream().map(line -> {
            String[] d = line.split(",");
            return DynamicTest.dynamicTest("WebTable: " + d[2], () -> runTableTest(d));
        }).collect(Collectors.toList());
    }

    void runTableTest(String[] data) throws InterruptedException {
        driver.get(BASE_URL);
        // Add new record
        safeClick("id=addNewRecordButton");
        driver.findElement(By.id("firstName")).sendKeys(data[0]);
        driver.findElement(By.id("lastName")).sendKeys(data[1]);
        driver.findElement(By.id("userEmail")).sendKeys(data[2]);
        driver.findElement(By.id("age")).sendKeys(data[3]);
        driver.findElement(By.id("salary")).sendKeys(data[4]);
        driver.findElement(By.id("department")).sendKeys(data[5]);
        safeClick("id=submit");
        Thread.sleep(1000);
        // Validate record
        String rowXpath = "//div[contains(@class, 'rt-tr-group')][.//div[text()='" + data[2] + "']]";
        WebElement row = driver.findElement(By.xpath(rowXpath));
        Assertions.assertEquals(data[0], row.findElements(By.cssSelector("div.rt-td")).get(0).getText());
        // Edit
        safeClick(rowXpath + "//span[@title='Edit']");
        driver.findElement(By.id("department")).clear();
        driver.findElement(By.id("department")).sendKeys("Edited_" + data[5]);
        safeClick("id=submit");
        Thread.sleep(1000);
        Assertions.assertTrue(driver.findElement(By.xpath(rowXpath + "//div[text()='Edited_" + data[5] + "']")).isDisplayed());
        // Delete
        safeClick(rowXpath + "//span[@title='Delete']");
        Thread.sleep(1000);
        Assertions.assertTrue(driver.findElements(By.xpath("//*[text()='" + data[2] + "']")).isEmpty());
    }

    void safeClick(String locator) {
        WebElement el = driver.findElement(By.xpath(locator.startsWith("id=") ? "//*[@id='" + locator.split("=")[1] + "']" : locator));
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", el);
    }
}
