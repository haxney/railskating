@scraping @importing @zsconcepts
Feature: Importing scraped ZSConcepts data
  In order to import results from dance.zsconcepts.com
  The parsed results page
  Should be imported into the database

  @single
  Scenario: Brown Comp 2013 event 5
    Given I import the event file "features/results_scrapers/event5.html" with "ZSConcepts" using 10 judges
    Then there should be 4 imported rounds
    And the imported level should be Bronze
    And the imported dance should be:
      | American Swing |

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

    And imported round 4 should have the following marks in the dance "American Swing":
      | number | A | B | E | F | G | I | J |
      |    152 | 8 | 7 | 5 | 8 | 3 | 6 | 7 |
      |    215 | 7 | 6 | 8 | 5 | 6 | 4 | 5 |
      |    223 | 6 | 3 | 4 | 2 | 4 | 1 | 2 |
      |    277 | 3 | 4 | 1 | 3 | 1 | 8 | 1 |
      |    295 | 4 | 5 | 7 | 1 | 7 | 2 | 3 |
      |    319 | 2 | 8 | 6 | 4 | 5 | 5 | 8 |
      |    335 | 1 | 2 | 2 | 7 | 2 | 3 | 6 |
      |    370 | 5 | 1 | 3 | 6 | 8 | 7 | 4 |

  @multi
  Scenario: Brown Comp 2013 event 13 (Silver International Waltz/Quickstep)
    Given I import the event file "features/results_scrapers/event13.html" with "ZSConcepts" using 10 judges
    Then the imported event should be number 13
    And there should be 3 rounds
    And the imported level should be Silver
    And the imported dances should be:
      | International Waltz     |
      | International Quickstep |

    And imported round 1 should have the following judges:
      | B |
      | E |
      | G |
      | I |
      | J |

    And imported round 1 should not be final
    And imported round 3 should be final
    And imported round 2 should have the following couples:
      | number | lead name           | lead team                             | follow name        | follow team                           |
      |    112 | Dilip Thekkoodan    | MIT                                   | Amy Fan            | MIT                                   |
      |    153 | Vince Gonski        | Boston University                     | Audrey Lai         | Boston University                     |
      |    162 | Lead Unknown        | Unknown Team                          | Follow Unknown     | Unknown Team                          |
      |    165 | Ross Finman         | MIT                                   | Ji Shiyan          | MIT                                   |
      |    203 | Jolyon Bloomfield   | MIT                                   | Nancy Li           | MIT                                   |
      |    213 | Daniel Pham         | Yale                                  | Miranda Kephart    | Yale                                  |
      |    222 | Ethan R White       | University of Vermont                 | Chelsea L Davidson | University of Vermont                 |
      |    223 | Derek Mullen        | Unaffiliated                          | Katrina Gocan      | Unaffiliated                          |
      |    270 | Thomas Solley       | Rensselaer Polytechnic Institute(RPI) | Megan Lamare       | Rensselaer Polytechnic Institute(RPI) |
      |    286 | Basil Siddiqui      | Harvard University                    | Connie Liu         | MIT                                   |
      |    310 | Drago Guggiana-Nilo | Harvard University                    | Shantel Mays       | Harvard University                    |
      |    345 | Roel Mercado        | Columbia University                   | Christina LaGamma  | Columbia University                   |
      |    365 | Doron Shiffer-Sebba | Brown University                      | Huyen Phan         | Brown University                      |
      |    503 | Kenny Brand         | University of Connecticut             | Sarah Falcetti     | University of Connecticut             |

    And imported round 2 should have the following marks in the dance "International Waltz":
      | number | B | E | F | I | J |
      |    112 | X | X |   | X | X |
      |    153 |   |   | X | X |   |
      |    162 | X |   |   | X | X |
      |    165 | X | X | X |   | X |
      |    203 |   |   |   |   |   |
      |    213 | X |   | X | X |   |
      |    222 |   | X | X |   |   |
      |    223 | X |   | X | X |   |
      |    270 |   |   | X |   |   |
      |    286 | X | X | X | X | X |
      |    310 |   | X |   |   | X |
      |    345 |   | X |   |   | X |
      |    365 | X | X |   | X | X |
      |    503 |   |   |   |   |   |

      And imported round 3 should have the following couples:
      | number | lead name           | lead team           | follow name       | follow team         |
      |    112 | Dilip Thekkoodan    | MIT                 | Amy Fan           | MIT                 |
      |    162 | Lead Unknown        | Unknown Team        | Follow Unknown    | Unknown Team        |
      |    165 | Ross Finman         | MIT                 | Ji Shiyan         | MIT                 |
      |    213 | Daniel Pham         | Yale                | Miranda Kephart   | Yale                |
      |    223 | Derek Mullen        | Unaffiliated        | Katrina Gocan     | Unaffiliated        |
      |    286 | Basil Siddiqui      | Harvard University  | Connie Liu        | MIT                 |
      |    345 | Roel Mercado        | Columbia University | Christina LaGamma | Columbia University |
      |    365 | Doron Shiffer-Sebba | Brown University    | Huyen Phan        | Brown University    |

    And imported round 3 should have the following marks in the dance "International Waltz":
      | number | A | B | E | F | G | I | J |
      |    112 | 1 | 2 | 1 | 2 | 1 | 3 | 1 |
      |    162 | 5 | 4 | 7 | 6 | 6 | 5 | 6 |
      |    165 | 4 | 1 | 8 | 3 | 5 | 6 | 3 |
      |    213 | 6 | 7 | 4 | 4 | 8 | 7 | 4 |
      |    223 | 3 | 3 | 6 | 5 | 2 | 2 | 5 |
      |    286 | 2 | 5 | 2 | 1 | 3 | 1 | 2 |
      |    345 | 7 | 8 | 3 | 8 | 4 | 8 | 8 |
      |    365 | 8 | 6 | 5 | 7 | 7 | 4 | 7 |

    And imported round 3 should have the following marks in the dance "International Quickstep":
      | number | A | B | E | F | G | I | J |
      |    112 | 1 | 2 | 1 | 1 | 1 | 1 | 1 |
      |    162 | 5 | 6 | 5 | 2 | 6 | 7 | 6 |
      |    165 | 2 | 1 | 3 | 6 | 5 | 5 | 4 |
      |    213 | 4 | 5 | 4 | 5 | 7 | 8 | 3 |
      |    223 | 7 | 3 | 7 | 4 | 3 | 3 | 7 |
      |    286 | 3 | 4 | 2 | 3 | 2 | 2 | 2 |
      |    345 | 6 | 8 | 6 | 8 | 4 | 4 | 5 |
      |    365 | 8 | 7 | 8 | 7 | 8 | 6 | 8 |

  @comp
  Scenario: Brown Comp 2013 event 13
    Given I import the competition file "features/results_scrapers/comp.html" with "ZSConcepts" and the events:
      | number | file name                              |
      |      5 | features/results_scrapers/event5.html  |
      |     13 | features/results_scrapers/event13.html |
      |     17 | features/results_scrapers/event17.html |

    Then the imported competition should be called "Brown Ballroom Competition"
    And the imported competition should have the following adjudicators:
      | shorthand | first name | last name  |
      | A         | Istvan     | Cserven    |
      | B         | Christine  | Harvey     |
      | C         | Ruta       | Loukhnikov |
      | D         | Helle      | Rusholt-Yi |
      | E         | Kalin      | Mitov      |
      | F         | Gail       | Rundlett   |
      | G         | Mark       | Sheldon    |
      | H         | Kathy      | St. Jean   |
      | I         | Michael    | ulbrich    |
      | J         | Peter      | Walker     |

    And the imported competition should have the following events:
      | number | level  | dances                                           |
      |      5 | Bronze | Swing                                            |
      |     13 | Silver | Waltz, Quickstep                                 |
      |     17 | Open   | Waltz, Quickstep, Foxtrot, Tango, Viennese Waltz |
