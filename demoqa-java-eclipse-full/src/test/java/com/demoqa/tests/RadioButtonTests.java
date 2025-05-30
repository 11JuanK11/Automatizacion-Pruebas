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

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class RadioButtonTests {

    WebDriver driver;
    ByteArrayOutputStream videoLog;

    static final String BASE_URL = "https://demoqa.com/radio-button";

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
    void testRadioYes() {
        driver.get(BASE_URL);
        driver.findElement(By.xpath("//div[@class='card-body']/h5[text()='Elements']")).click();
        driver.findElement(By.xpath("//span[text()='Radio Button']")).click();
        sleep(1000);
        driver.findElement(By.xpath("//label[@for='yesRadio']")).click();
        String result = driver.findElement(By.cssSelector("span.text-success")).getText();
        Assertions.assertEquals("Yes", result);
    }

    @Test
    void testRadioImpressive() {
        driver.get(BASE_URL);
        driver.findElement(By.xpath("//div[@class='card-body']/h5[text()='Elements']")).click();
        driver.findElement(By.xpath("//span[text()='Radio Button']")).click();
        sleep(1000);
        driver.findElement(By.xpath("//label[@for='impressiveRadio']")).click();
        String result = driver.findElement(By.cssSelector("span.text-success")).getText();
        Assertions.assertEquals("Impressive", result);
    }

    @Test
    void testRadioNoDisabled() {
        driver.get(BASE_URL);
        driver.findElement(By.xpath("//div[@class='card-body']/h5[text()='Elements']")).click();
        driver.findElement(By.xpath("//span[text()='Radio Button']")).click();
        sleep(1000);
        WebElement no = driver.findElement(By.id("noRadio"));
        Assertions.assertFalse(no.isEnabled());
    }

    private void sleep(long ms) {
        try { Thread.sleep(ms); } catch (InterruptedException e) { }
    }
}
