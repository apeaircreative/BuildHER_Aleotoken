# BuildHER_Aleotoken

A transparent & shielded custom token in Leo.

## Overview

This project builds upon the foundational concepts introduced in the BuildHER workshop by Aleo. It explores creating a custom token using the Leo language, while enhancing the original script with new features and personal modifications. As a designer with limited coding experience, this project represents my journey into smart contract development and troubleshooting.

## Journey and Process

As a designer with minimal coding experience, I relied heavily on AI assistance and community resources to navigate this project. My journey was full of iterative trial and error, as I tried to understand not only the Leo language but also the process of structuring a project like this. Throughout, I maintained a mindset of learning and experimentation. This section captures the key milestones and challenges faced while working on this project.

### Challenges

1. **Testing in Leo:**
   - Initially, I struggled with structuring the test functions. Leo’s strict syntax and documentation, while helpful, often left me confused when attempting to run my tests separately from the main program. This led to multiple iterations where tests were moved between files and different approaches were tried based on feedback and errors received.

2. **Error Handling and Debugging:**
   - Many of the errors I encountered were due to minor syntax issues, but they often required deep troubleshooting. For instance, separating the test functions from the main program was one of the major challenges. Moving tests between files resulted in numerous build errors, leading to a back-and-forth process where I consulted the documentation, restructured the code, and tried different solutions.

3. **Environment Management:**
   - Managing environment variables securely and ensuring sensitive information like private keys was stored safely became an important step. I utilized `.env` files for this, a concept that was new to me but crucial for the project’s security.

4. **Understanding Leo's Build Process:**
   - The build process in Leo involved multiple iterations of trial and error. At one point, I had to manually adjust the testing setup to prevent errors in the script, learning how to automate parts of the process while ensuring the core functionality was intact.

5. **Frustration and Perseverance:**
   - The project involved many moments of frustration—seeing the same errors repeatedly and trying various fixes. However, each step provided a valuable learning experience. Moving forward, I plan to document these learning curves to help others who may be on a similar journey.

### Key Learnings

- **Syntax and Structure:** Understanding Leo’s specific syntax for function calls, test setups, and async functionality was critical. I often returned to the official Leo documentation to cross-reference details and resolve issues.
- **Automation and Scripting:** Developing the `run.sh` script was a highlight, allowing me to streamline the process and automate repetitive tasks. This also helped me learn more about how to handle tests and separate environments within a project.
- **Collaboration with AI:** While I used AI assistance to troubleshoot and navigate through code errors, I learned to critically analyze the feedback to fit the project's specific requirements and context.

## Key Enhancements

1. **Token Minting and Transfer:**
   - Expanded upon the workshop example to implement both public and private minting functions.
   - Added checks and assertions to ensure that balances and transfers behave appropriately.

2. **Improved Transfer Mechanisms:**
   - Included the ability to convert between public and private tokens seamlessly, allowing for a more versatile token management system.

3. **Testing Setup:**
   - Created automated test functions for minting and transferring tokens. Initially, tests were integrated into the main file but later separated into their own file to follow best practices.

4. **Environment Configuration:**
   - Established distinct `.env` files for each account (Alice and Bob) to ensure the secure handling of private keys and other sensitive information.

## Run Guide

To run this program, execute the following command:
```bash
./run.sh {account1|account2}

Replace `{account1|account2}` with the appropriate account you wish to use.

## Workshop Reference

For a detailed walkthrough of the original implementation, you can watch the BuildHER workshop on YouTube: [BuildHER Workshop](https://www.youtube.com/watch?v=slVmiwqNiRw).

## Acknowledgments

Thanks to the Aleo team for the workshop and resources that helped in building this project. Special thanks to AI-driven resources and developer communities for the troubleshooting guidance.
