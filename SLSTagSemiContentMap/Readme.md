

# SLSTagSemiContentMap

## Overview
This directory contains the SLSTagSemiContentMap project, a tool for tagging content maps in lessons. It is designed to work best on a computer that auto-fills passwords to SLS.

## Parameters
The script requires the following parameters:

1. `p1`: Part of the URL that forms the ID of the lesson (e.g., `1aff6f7f-5deb-41e3-8389-afc856c5a1fb/cover`)
2. `p2`: The content syllabus to add (e.g., `1`, `2`, or `3` depending on which content map to add)
3. `p3`: Level of content map (e.g., `Secondary_2_Express`)
4. `p4`: Subject (e.g., `21st_Century_Competencies_-_21CC`)
5. `p5`: The URL ID of the progressive quiz page (e.g., `1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472`)

## Usage
To run the script in a command line tool, type the following command:

```bash
tagui tagSemiContentMapLesson.tag 1aff6f7f-5deb-41e3-8389-afc856c5a1fb/cover 3 Secondary_2_Express 21st_Century_Competencies_-_21CC 1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472
```

## Assumptions
This script is a first-level tagging tool and does not yet have the ability to do intelligent content map tagging. It assumes that you are using a computer that auto-fills passwords to SLS. Manual password entry may require additional configuration.

## Contributing
Details on our code of conduct, and the process for submitting pull requests to us.

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
- kensoh

```


Readme
// Define parameters
// first p1 is part of the url that forms the id of the lesson, expecting 1aff6f7f-5deb-41e3-8389-afc856c5a1fb/cover
// p2 is 3 for third content syllabus to add, expect 1 , 2 or 3 depending on which content map to add, usually is 1 assuming new lesson
// p3 is level of content map, expecting Secondary_2_Express with _ added
// p4 is subject, expecting 21st_Century_Competencies_-_21CC with _ added
// p5 is the URL id of the progressive quiz page, expecting   1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472

// How to Run in Command Line tool, type this inside command line
// tagui tagSemiContentMapLesson.tag 1aff6f7f-5deb-41e3-8389-afc856c5a1fb/cover 3 Secondary_2_Express 21st_Century_Competencies_-_21CC 1aff6f7f-5deb-41e3-8389-afc856c5a1fb/page/46993472

//Assumptions
// work best on a computer that auto fill password to SLS, will need some configuration for manual key in passwords machines
// this is a first level tagging, it doesnt have the ability to do intelligent content map tagging yet
