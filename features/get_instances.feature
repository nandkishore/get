Feature: Add run records by running the get instances 

  Scenario: Add a new Run Record
    Given the Background Job does not exist
    When I successfully run `get instances`
    Then the output should contain "=============== Run record saved successfully! ==============="
  Scenario: background job should not be queued if there exists background job to avoid duplication
    Given the Background Job exist
    When I successfully run `get instances`
    Then the output should contain "Background Job already in queue"

  Scenario: Background job should be queued to run each hour
    Given the Background Job does not exist
    When I successfully run `get instances`
    Then the Backgroud job shuld be scheduled to run in an hour