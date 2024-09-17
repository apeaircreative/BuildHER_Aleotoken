# BuildHER_Aleotoken

A transparent & shielded custom token in Leo.

## Overview

This project is based on the BuildHER workshop from Aleo. The original workshop provided a foundational understanding of creating a custom token using Leo. Below are the key changes and enhancements made to the original script.

## Changes Made

1. **Enhanced Token Minting:**
   - Implemented both public and private minting functions for tokens.
   - Added checks to ensure sufficient balances during transfers.

2. **Improved Transfer Functions:**
   - Created functions for transferring tokens between accounts, both publicly and privately.
   - Added assertions to handle insufficient funds gracefully.

3. **Conversion Between Token Types:**
   - Implemented functionality to convert public tokens to private tokens and vice versa.

4. **Environment Management:**
   - Utilized `.env` files to manage sensitive information securely.

5. **Script Automation:**
   - Developed a comprehensive script (`run.sh`) to automate the minting and transferring processes, making it easier to execute multiple operations in sequence.

## Workshop Reference

For a detailed walkthrough of the original implementation, you can watch the BuildHER workshop on YouTube: [BuildHER Workshop](https://www.youtube.com/watch?v=slVmiwqNiRw).

## Run Guide

To run this program, execute the following command:
bash
./run.sh {account1|account2}

Replace `{accountaccount2}` with the appropriate account you wish to use.

## Acknowledgments

Thanks to the Aleo team for the workshop and resources that helped in building this project.