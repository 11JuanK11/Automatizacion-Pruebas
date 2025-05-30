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
public class DropdownTextFieldsTest {

    WebDriver driver;
    ByteArrayOutputStream videoLog;

    static final String BASE_URL = "https://demoqa.com/text-box";

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

    @TestFactory
    Collection<DynamicTest> dataDriven() throws Exception {
        List<String> lines = Files.readAllLines(Path.of("src/test/resources/datos.csv"));
        lines.remove(0);
        return lines.stream().map(line -> {
            String[] data = line.split(";"); return DynamicTest.dynamicTest("Test: " + data[0], () -> runTest(data));
        }).collect(Collectors.toList());
    }

    void runTest(String[] data) throws InterruptedException {
        driver.get(BASE_URL);
        Thread.sleep(2000);
        // Campos de texto
        driver.findElement(By.xpath("/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[1]/div[2]/input")).sendKeys(data[0]);
        driver.findElement(By.xpath("/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[2]/div[2]/input")).sendKeys(data[1]);
        driver.findElement(By.xpath("/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[3]/div[2]/textarea")).sendKeys(data[2]);
        driver.findElement(By.xpath("/html/body/div[2]/div/div/div/div[2]/div[2]/form/div[4]/div[2]/textarea")).sendKeys(data[3]);
        driver.findElement(By.id("submit")).click();
        
        //driver.findElement(By.xpath("//button[text()='Submit']")).click();
        Thread.sleep(2000);
        Assertions.assertTrue(driver.findElement(By.id("output")).getText() != "");
    }
}
