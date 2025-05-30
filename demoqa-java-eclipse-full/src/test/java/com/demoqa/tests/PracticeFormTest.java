package com.demoqa.tests;

import org.junit.jupiter.api.*;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import io.github.bonigarcia.wdm.WebDriverManager;

import java.io.*;
import java.nio.file.*;
import java.time.Duration;
import java.util.*;
import java.util.stream.Collectors;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class PracticeFormTest {

    WebDriver driver;
    ByteArrayOutputStream videoLog;

    static final String BASE_URL = "https://demoqa.com/automation-practice-form";
    static final String IMAGE_PATH = "src/test/resources/photo.png";

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
    void tearDown(TestInfo info) throws IOException {
        // ScreenCapLibrary functionality
        TakesScreenshot ts = (TakesScreenshot) driver;
        File screenshot = ts.getScreenshotAs(OutputType.FILE);
        Files.copy(screenshot.toPath(), Path.of("target/screenshots/" + info.getDisplayName() + "_" + System.currentTimeMillis() + ".png"));
        driver.quit();
    }

    @AfterAll
    void teardownAll() throws IOException {
        // AutoRecorder functionality: save logs
        Files.write(Path.of("target/suite_log.txt"), videoLog.toByteArray());
    }

    @TestFactory
    Collection<DynamicTest> dataDrivenTests() throws IOException {
        List<String> lines = Files.readAllLines(Path.of("src/test/resources/students.csv"));
        lines.remove(0);
        return lines.stream().map(line -> {
            String[] data = line.split(";");
            return DynamicTest.dynamicTest("Submit form: " + data[0] + " " + data[1], () -> submitForm(data));
        }).collect(Collectors.toList());
    }

    void submitForm(String[] data) throws InterruptedException {
        driver.get(BASE_URL);
        Thread.sleep(2000);
        driver.findElement(By.id("firstName")).sendKeys(data[0]);
        Thread.sleep(500);
        driver.findElement(By.id("lastName")).sendKeys(data[1]);
        Thread.sleep(500);
        driver.findElement(By.id("userEmail")).sendKeys(data[2]);
        Thread.sleep(500);
        driver.findElement(By.xpath("//label[text()='" + data[3] + "']")).click();
        Thread.sleep(500);
        driver.findElement(By.id("userNumber")).sendKeys(data[4]);
        Thread.sleep(500);
        driver.findElement(By.xpath("//label[text()='" + data[9] + "']")).click();
        Thread.sleep(500);
        driver.findElement(By.id("uploadPicture")).sendKeys(new File(IMAGE_PATH).getAbsolutePath());
        Thread.sleep(500);
        driver.findElement(By.id("currentAddress")).sendKeys("Avenida Siempre Viva 123");
        Thread.sleep(500);
        driver.findElement(By.xpath("//div[contains(text(),'Select State')]")).click();
        driver.findElement(By.xpath("//div[text()='" + data[10] + "']")).click();
        Thread.sleep(500);
        driver.findElement(By.xpath("//div[contains(text(),'Select City')]")).click();
        driver.findElement(By.xpath("//div[text()='" + data[11] + "']")).click();
        Thread.sleep(500);
        driver.findElement(By.id("submit")).click();
        //driver.findElement(By.xpath("//button[text()='Submit']")).click();
        Thread.sleep(3000);
        Assertions.assertTrue(driver.findElement(By.id("example-modal-sizes-title-lg")).isDisplayed());
    }
}
