load test_helper

@test "Ignore short descriptions between 50 and 300 characters" {
  run run_vale "$BATS_TEST_FILENAME" ignore_valid.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Accept a short description with exactly 50 characters" {
  run run_vale "$BATS_TEST_FILENAME" ignore_boundary.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Accept a short description with exactly 300 characters" {
  run run_vale "$BATS_TEST_FILENAME" ignore_max_boundary.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Count wrapped lines as one paragraph" {
  run run_vale "$BATS_TEST_FILENAME" ignore_wrapped.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore paragraphs without [role=\"_abstract\"]" {
  run run_vale "$BATS_TEST_FILENAME" ignore_unmarked.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Ignore code blocks after [role=\"_abstract\"]" {
  run run_vale "$BATS_TEST_FILENAME" ignore_code_block.adoc
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "Report short descriptions shorter than 50 characters" {
  run run_vale "$BATS_TEST_FILENAME" report_too_short.adoc
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 1 ]
  [ "${lines[0]}" = "report_too_short.adoc:5:1:AsciiDocDITA.ShortDescLength:Short descriptions must be between 50 and 300 characters." ]
}

@test "Report short descriptions longer than 300 characters" {
  run run_vale "$BATS_TEST_FILENAME" report_too_long.adoc
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 1 ]
  [ "${lines[0]}" = "report_too_long.adoc:5:1:AsciiDocDITA.ShortDescLength:Short descriptions must be between 50 and 300 characters." ]
}
