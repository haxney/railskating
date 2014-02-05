@scraping @zsconcepts
Feature: Scraping from dance.zsconcepts.com
  In order to pull results from dance.zsconcepts.com
  The events page
  Should be parsed into a structure

  @multi
  Scenario: Brown Comp 2013 event 13 (Silver International Waltz/Quickstep)
    Given I fetch and parse event 13 from comp "brown2013" with "ZSConcepts"
    Then the event should be number 13
    And there should be 3 rounds
    And the level should be Silver
    And the section should be International
    And the dances should be:
      | Waltz     |
      | Quickstep |

    And round 1 should have the following judges:
      | B |
      | E |
      | G |
      | I |
      | J |

    And round 1 should not be final
    And round 3 should be final
    And round 2 should have the following couples:
      | number | lead name           | lead team                             | follow name        | follow team                           | no name |
      |    112 | Dilip Thekkoodan    | MIT                                   | Amy Fan            | MIT                                   |         |
      |    153 | Vince Gonski        | Boston University                     | Audrey Lai         | Boston University                     |         |
      |    162 |                     |                                       |                    |                                       | true    |
      |    165 | Ross Finman         | MIT                                   | Ji Shiyan          | MIT                                   |         |
      |    203 | Jolyon Bloomfield   | MIT                                   | Nancy Li           | MIT                                   |         |
      |    213 | Daniel Pham         | Yale                                  | Miranda Kephart    | Yale                                  |         |
      |    222 | Ethan R White       | University of Vermont                 | Chelsea L Davidson | University of Vermont                 |         |
      |    223 | Derek Mullen        | Unaffiliated                          | Katrina Gocan      | Unaffiliated                          |         |
      |    270 | Thomas Solley       | Rensselaer Polytechnic Institute(RPI) | Megan Lamare       | Rensselaer Polytechnic Institute(RPI) |         |
      |    286 | Basil Siddiqui      | Harvard University                    | Connie Liu         | MIT                                   |         |
      |    310 | Drago Guggiana-Nilo | Harvard University                    | Shantel Mays       | Harvard University                    |         |
      |    345 | Roel Mercado        | Columbia University                   | Christina LaGamma  | Columbia University                   |         |
      |    365 | Doron Shiffer-Sebba | Brown University                      | Huyen Phan         | Brown University                      |         |
      |    503 | Kenny Brand         | University of Connecticut             | Sarah Falcetti     | University of Connecticut             |         |

    And round 2 should have the following marks in the dance "Waltz":
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

      And round 3 should have the following couples:
      | number | lead name           | lead team           | follow name       | follow team         | no name |
      |    112 | Dilip Thekkoodan    | MIT                 | Amy Fan           | MIT                 |         |
      |    162 |                     |                     |                   |                     | true    |
      |    165 | Ross Finman         | MIT                 | Ji Shiyan         | MIT                 |         |
      |    213 | Daniel Pham         | Yale                | Miranda Kephart   | Yale                |         |
      |    223 | Derek Mullen        | Unaffiliated        | Katrina Gocan     | Unaffiliated        |         |
      |    286 | Basil Siddiqui      | Harvard University  | Connie Liu        | MIT                 |         |
      |    345 | Roel Mercado        | Columbia University | Christina LaGamma | Columbia University |         |
      |    365 | Doron Shiffer-Sebba | Brown University    | Huyen Phan        | Brown University    |         |

    And round 3 should have the following marks in the dance "Waltz":
      | number | A | B | E | F | G | I | J |
      |    112 | 1 | 2 | 1 | 2 | 1 | 3 | 1 |
      |    162 | 5 | 4 | 7 | 6 | 6 | 5 | 6 |
      |    165 | 4 | 1 | 8 | 3 | 5 | 6 | 3 |
      |    213 | 6 | 7 | 4 | 4 | 8 | 7 | 4 |
      |    223 | 3 | 3 | 6 | 5 | 2 | 2 | 5 |
      |    286 | 2 | 5 | 2 | 1 | 3 | 1 | 2 |
      |    345 | 7 | 8 | 3 | 8 | 4 | 8 | 8 |
      |    365 | 8 | 6 | 5 | 7 | 7 | 4 | 7 |

    And round 3 should have the following marks in the dance "Quickstep":
      | number | A | B | E | F | G | I | J |
      |    112 | 1 | 2 | 1 | 1 | 1 | 1 | 1 |
      |    162 | 5 | 6 | 5 | 2 | 6 | 7 | 6 |
      |    165 | 2 | 1 | 3 | 6 | 5 | 5 | 4 |
      |    213 | 4 | 5 | 4 | 5 | 7 | 8 | 3 |
      |    223 | 7 | 3 | 7 | 4 | 3 | 3 | 7 |
      |    286 | 3 | 4 | 2 | 3 | 2 | 2 | 2 |
      |    345 | 6 | 8 | 6 | 8 | 4 | 4 | 5 |
      |    365 | 8 | 7 | 8 | 7 | 8 | 6 | 8 |

  @single
  Scenario: Brown Comp 2013 event 5 (Bronze American Swing)
    Given I fetch and parse event 5 from comp "brown2013" with "ZSConcepts"
    Then the event should be number 5
    And there should be 4 rounds
    And the level should be Bronze
    And the section should be American
    And the dance should be:
      | Swing |

    And round 1 should have the following judges:
      | B |
      | E |
      | F |
      | G |
      | J |

    And round 1 should not be final
    And round 4 should be final
    And round 3 should have the following couples:
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

    And round 3 should have the following marks in the dance "Swing":
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

    And round 4 should have the following judges:
      | A |
      | B |
      | E |
      | F |
      | G |
      | I |
      | J |

    And round 4 should have the following couples:
      | number | lead name          | lead team                 | follow name        | follow team               |
      |    152 | Vincent van Mierlo | Boston University         | Elisha Machado     | Boston University         |
      |    215 | David Molina       | Yale                      | Miranda Kephart    | Yale                      |
      |    223 | Derek Mullen       | Unaffiliated              | Katrina Gocan      | Unaffiliated              |
      |    277 | Yelena Mirsakova   | Stony Brook University    | Katherine Georgios | Stony Brook University    |
      |    295 | Max Greenhouse     | Tufts University          | Skye Lewis         | Tufts University          |
      |    319 | Nick Athanasidy    | College of the Holy Cross | Sophia Jin         | College of the Holy Cross |
      |    335 | Isaac Alter        | Harvard University        | Sophie Welsh       | Harvard University        |
      |    370 | Michael Scheer     | Brown University          | Angelia Wang       | Brown University          |

    And round 4 should have the following marks in the dance "Swing":
      | number | A | B | E | F | G | I | J |
      |    152 | 8 | 7 | 5 | 8 | 3 | 6 | 7 |
      |    215 | 7 | 6 | 8 | 5 | 6 | 4 | 5 |
      |    223 | 6 | 3 | 4 | 2 | 4 | 1 | 2 |
      |    277 | 3 | 4 | 1 | 3 | 1 | 8 | 1 |
      |    295 | 4 | 5 | 7 | 1 | 7 | 2 | 3 |
      |    319 | 2 | 8 | 6 | 4 | 5 | 5 | 8 |
      |    335 | 1 | 2 | 2 | 7 | 2 | 3 | 6 |
      |    370 | 5 | 1 | 3 | 6 | 8 | 7 | 4 |

  @comp
  Scenario: Brown Comp 2013
    Given I fetch and parse the competition "brown2013" with "ZSConcepts"
    Then the competition should be called "Brown Ballroom Competition"
    And the year should be 2013
    And the competition should have the following adjudicators:
      | shorthand | name             |
      | A         | Istvan Cserven   |
      | B         | Christine Harvey |
      | C         | Ruta Loukhnikov  |
      | D         | Helle Rusholt-Yi |
      | E         | Kalin Mitov      |
      | F         | Gail Rundlett    |
      | G         | Mark Sheldon     |
      | H         | Kathy St. Jean   |
      | I         | Michael ulbrich  |
      | J         | Peter Walker     |

    And the competition should have the following events:
      | number | file name    |
      |      1 | event1.html  |
      |      5 | event5.html  |
      |     13 | event13.html |
      |     17 | event17.html |

  @multi @event17
  Scenario: Brown Comp 2013 event 17 (Open International 5-dance)
    Given I fetch and parse event 17 from comp "brown2013" with "ZSConcepts"
    Then the event should be number 17
    And there should be 2 rounds
    And the level should be Open
    And the section should be International
    And the dances should be:
      | Waltz          |
      | Quickstep      |
      | Foxtrot        |
      | Tango          |
      | Viennese Waltz |

    And round 1 should have the following judges:
      | A |
      | B |
      | E |
      | F |
      | G |
      | I |
      | J |

    And round 1 should not be final
    And round 2 should be final
    And round 1 should have the following couples:
      | number | lead name          | lead team                | follow name        | follow team          | no name |
      |    102 | Matthew Sorrentino | MIT                      | Theresa Vallese    | MIT                  |         |
      |    104 | Andrey Grinshpun   | MIT                      | Mandi Davis        | MIT                  |         |
      |    111 | Ben Moss           | MIT                      | Esther Rheinbay    | MIT                  |         |
      |    113 | Arthur Lue         | Boston Dance Options/MIT | Sarah Wong         | Boston Dance Options |         |
      |    114 | Paul Tillman       | Boston Dance Options     | Mutsuko Ohnishi    | MIT                  |         |
      |    157 | Zach Germain       | MIT                      | Lu Wang            | Unaffiliated         |         |
      |    163 | Jonathan Liu       | Yale                     | Annie Yao          | Yale                 |         |
      |    166 | Ping Zhang         | Boston University        | Courtney Delmonico | UConn                |         |
      |    168 | Michael Otero      | Unaffiliated             | Diane Darling      | Unaffiliated         |         |
      |    183 | Kevin Liu Huang    | Harvard University       | Lihua Bai          | MIT                  |         |
      |    184 | Mark Chen          | MIT                      | Bella Pindrus      | Boston Dance Options |         |
      |    189 | Cloud Cray         | Boston Dance Options     | Noelle Sun         | Boston Dance Options |         |
      |    225 | Jeff McCollum      | MIT                      | Anna Poberetsky    | Unaffiliated         |         |
      |    293 | Paul Freitas       | Unaffiliated             | Kelly Glasheen     | Unaffiliated         |         |
      |    300 | Meredith Stead     | Unaffiliated             | Daphna Locker      | Unaffiliated         |         |
      |    346 | Alan Wong          | UConn                    | Amy Friss          | UConn                |         |
      |    388 |                    |                          |                    |                      | true        |

    And round 1 should have the following marks in the dance "Tango":
      | number | A | B | E | F | G | I | J |
      |    102 |   |   |   |   |   | X |   |
      |    104 |   |   |   |   |   |   |   |
      |    111 | X | X | X | X | X | X | X |
      |    113 | X | X | X | X | X | X | X |
      |    114 | X | X |   | X | X | X | X |
      |    157 |   |   | X |   |   |   | X |
      |    163 |   | X |   | X | X |   | X |
      |    166 |   |   |   |   |   |   |   |
      |    168 | X |   |   |   |   |   |   |
      |    183 |   | X | X |   |   | X |   |
      |    184 |   |   |   |   |   |   |   |
      |    189 | X | X | X | X | X | X | X |
      |    225 |   |   |   |   |   |   |   |
      |    293 |   |   |   |   |   |   |   |
      |    300 |   |   | X |   | X |   |   |
      |    346 | X | X | X | X | X | X | X |
      |    388 | X |   |   | X |   |   |   |

      And round 2 should have the following couples:
      | number | lead name       | lead team                | follow name     | follow team          |
      |    111 | Ben Moss        | MIT                      | Esther Rheinbay | MIT                  |
      |    113 | Arthur Lue      | Boston Dance Options/MIT | Sarah Wong      | Boston Dance Options |
      |    114 | Paul Tillman    | Boston Dance Options     | Mutsuko Ohnishi | MIT                  |
      |    163 | Jonathan Liu    | Yale                     | Annie Yao       | Yale                 |
      |    183 | Kevin Liu Huang | Harvard University       | Lihua Bai       | MIT                  |
      |    189 | Cloud Cray      | Boston Dance Options     | Noelle Sun      | Boston Dance Options |
      |    346 | Alan Wong       | UConn                    | Amy Friss       | UConn                |

    And round 2 should have the following marks in the dance "Foxtrot":
      | number | A | B | E | F | G | I | J |
      |    111 | 1 | 2 | 1 | 5 | 2 | 2 | 2 |
      |    113 | 2 | 1 | 2 | 3 | 1 | 1 | 1 |
      |    114 | 4 | 5 | 6 | 4 | 5 | 6 | 7 |
      |    163 | 5 | 6 | 5 | 2 | 4 | 4 | 4 |
      |    183 | 7 | 7 | 4 | 6 | 7 | 7 | 6 |
      |    189 | 3 | 3 | 3 | 1 | 3 | 3 | 3 |
      |    346 | 6 | 4 | 7 | 7 | 6 | 5 | 5 |

    And round 2 should have the following marks in the dance "Viennese Waltz":
      | number | A | B | E | F | G | I | J |
      |    111 | 2 | 1 | 1 | 4 | 1 | 1 | 1 |
      |    113 | 1 | 2 | 2 | 2 | 2 | 2 | 2 |
      |    114 | 4 | 6 | 7 | 1 | 5 | 7 | 6 |
      |    163 | 5 | 5 | 4 | 3 | 4 | 6 | 5 |
      |    183 | 7 | 7 | 5 | 5 | 7 | 3 | 7 |
      |    189 | 3 | 3 | 3 | 7 | 3 | 5 | 3 |
      |    346 | 6 | 4 | 6 | 6 | 6 | 4 | 4 |
