#!/bin/bash
# Script to run the SLS Review Playwright test
cd "$(dirname "$0")"
npx playwright test loginslsrV2_2026wog.ts --headed
