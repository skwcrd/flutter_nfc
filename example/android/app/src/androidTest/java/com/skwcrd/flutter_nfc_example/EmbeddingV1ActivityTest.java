package com.skwcrd.flutter_nfc_example;

import org.junit.Rule;
import org.junit.runner.RunWith;

import androidx.test.rule.ActivityTestRule;
import dev.flutter.plugins.integration_test.FlutterTestRunner;

@RunWith(FlutterTestRunner.class)
public class EmbeddingV1ActivityTest {
    @Rule
    public ActivityTestRule<EmbeddingV1Activity> rule =
        new ActivityTestRule<>(EmbeddingV1Activity.class);
}