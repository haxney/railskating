@scraping @importing @zsconcepts
Feature: Importing scraped ZSConcepts data
  In order to import results from dance.zsconcepts.com
  The parsed results page
  Should be imported into the database

  @single
  Scenario: Brown Comp 2013 event 5
    Given I import the file "features/results_scrapers/event5.html" with "ZSConcepts" using 10 judges
    Then there should be 4 imported rounds
    And the imported level should be Bronze
    And the imported dances should be:
      | Swing |

    And imported round 1 should have the following judges:
      | B |
      | E |
      | F |
      | G |
      | J |

    And imported round 1 should not be final
    And imported round 4 should be final
    And imported round 3 should have the following couples:
      | number | lead name          | lead team                 | follow name        | follow team               |
      |    117 | Torin Harthcock    | Paper Moon Dance          | Kate King          | Paper Moon Dance          |
      |    124 | Steven Angelos     | UMass Amherst             | Val Locke          | UMass Amherst             |
      |    152 | Vincent van Mierlo | Boston University         | Elisha Machado     | Boston University         |
      |    194 | Johan Mohtarudin   | Bates College             | Hilary Gibson      | Bates College             |
      |    215 | David Molina       | Yale                      | Miranda Kephart    | Yale                      |
      |    223 | Derek Mullen       | Unaffiliated              | Katrina Gocan      | Unaffiliated              |
      |    250 | Eric Newbury       | University of Vermont     | Kate Von Alt       | University of Vermont     |
      |    253 | Selene Clark       | University of Vermont     | Victoria Kominek   | University of Vermont     |
      |    277 | Yelena Mirsakova   | Stony Brook University    | Katherine Georgios | Stony Brook University    |
      |    288 | Keno Fischer       | Harvard University        | Cristina Foyo      | Harvard University        |
      |    295 | Max Greenhouse     | Tufts University          | Skye Lewis         | Tufts University          |
      |    319 | Nick Athanasidy    | College of the Holy Cross | Sophia Jin         | College of the Holy Cross |
      |    335 | Isaac Alter        | Harvard University        | Sophie Welsh       | Harvard University        |
      |    370 | Michael Scheer     | Brown University          | Angelia Wang       | Brown University          |
      |    373 | Spencer Caplan     | Brown University          | Alexandra Buczek   | Brown University          |
      |    400 | Emma DiFrancesco   | Tufts University          | Amelia Wills       | Tufts University          |

    And imported round 3 should have the following marks in the dance "American Swing":
      | number | B | F | G | I | J |
      |    117 |   | X | X |   |   |
      |    124 |   |   |   |   |   |
      |    152 | X | X | X | X |   |
      |    194 |   | X |   |   |   |
      |    215 |   |   | X | X | X |
      |    223 | X |   |   | X | X |
      |    250 | X |   |   |   | X |
      |    253 |   |   |   |   | X |
      |    277 | X |   | X |   | X |
      |    288 |   |   |   | X | X |
      |    295 | X | X | X | X | X |
      |    319 |   | X | X | X |   |
      |    335 | X | X | X | X |   |
      |    370 | X | X | X | X |   |
      |    373 | X |   |   |   | X |
      |    400 |   | X |   |   |   |

    And imported round 4 should have the following judges:
      | A |
      | B |
      | E |
      | F |
      | G |
      | I |
      | J |

    And imported round 4 should have the following couples:
      | number | lead name          | lead team                 | follow name        | follow team               |
      |    152 | Vincent van Mierlo | Boston University         | Elisha Machado     | Boston University         |
      |    215 | David Molina       | Yale                      | Miranda Kephart    | Yale                      |
      |    223 | Derek Mullen       | Unaffiliated              | Katrina Gocan      | Unaffiliated              |
      |    277 | Yelena Mirsakova   | Stony Brook University    | Katherine Georgios | Stony Brook University    |
      |    295 | Max Greenhouse     | Tufts University          | Skye Lewis         | Tufts University          |
      |    319 | Nick Athanasidy    | College of the Holy Cross | Sophia Jin         | College of the Holy Cross |
      |    335 | Isaac Alter        | Harvard University        | Sophie Welsh       | Harvard University        |
      |    370 | Michael Scheer     | Brown University          | Angelia Wang       | Brown University          |

    And imported round 4 should have the following marks in the dance "Swing":
      | number | A | B | E | F | G | I | J |
      |    152 | 8 | 7 | 5 | 8 | 3 | 6 | 7 |
      |    215 | 7 | 6 | 8 | 5 | 6 | 4 | 5 |
      |    223 | 6 | 3 | 4 | 2 | 4 | 1 | 2 |
      |    277 | 3 | 4 | 1 | 3 | 1 | 8 | 1 |
      |    295 | 4 | 5 | 7 | 1 | 7 | 2 | 3 |
      |    319 | 2 | 8 | 6 | 4 | 5 | 5 | 8 |
      |    335 | 1 | 2 | 2 | 7 | 2 | 3 | 6 |
      |    370 | 5 | 1 | 3 | 6 | 8 | 7 | 4 |
