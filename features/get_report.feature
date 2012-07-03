Feature: Generates reports for cost and utilization 

  Scenario: Run the report command to generate reports for Utilization
    Given there are run and utilization records
    When I successfully run `get report --time-period="day" --variable="utilization" --start-time="05-01-2012" --end-time="07-30-2012" --attribute="flavor"`
    Then the output should contain "DATE"
    And the output should contain "NETWORK"
    And the output should contain "CPU"
    And the output should contain "FLAVOR"

 Scenario: Run the report command to generate reports for Cost
    Given there are run and utilization records
    When I successfully run `get report --time-period="week" --variable="cost" --start-time="05-01-2012" --end-time="07-30-2012" --attribute="region"`
    Then the output should contain "DATE"
    And the output should contain "COST"
    And the output should contain "REGION"
    