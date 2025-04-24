rule ExampleRule {
    strings:
        $example_string = "example_text"
    condition:
        $example_string
}
