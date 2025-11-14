# GitHub Copilot Instructions for chef-gyoku

## Repository Overview

The `chef-gyoku` repository is a Ruby gem that translates Ruby Hashes to XML. This is a Chef-maintained fork of the original Gyoku gem with Chef-specific customizations and requirements.

### Project Structure

```
chef-gyoku/
├── .github/
│   ├── workflows/
│   │   ├── ci.yml                    # CI pipeline for Ruby 3.1 & 3.4
│   │   └── lint.yml                  # Cookstyle linting workflow
│   ├── dependabot.yml               # Dependency management
│   └── copilot-instructions.md      # This file
├── lib/
│   ├── chef-gyoku.rb                 # Main entry point
│   └── chef-gyoku/
│       ├── array.rb                  # Array to XML conversion
│       ├── hash.rb                   # Hash to XML conversion
│       ├── prettifier.rb             # XML prettification
│       ├── version.rb                # Gem version
│       ├── xml_key.rb                # XML key handling
│       └── xml_value.rb              # XML value handling
├── spec/
│   ├── chef-gyoku_spec.rb            # Main gem specs
│   ├── spec_helper.rb                # Test configuration
│   └── chef-gyoku/
│       ├── array_spec.rb             # Array conversion tests
│       ├── hash_spec.rb              # Hash conversion tests
│       ├── prettifier_spec.rb        # Prettifier tests
│       ├── xml_key_spec.rb           # XML key tests
│       └── xml_value_spec.rb         # XML value tests
├── chef-gyoku.gemspec               # Gem specification
├── Gemfile                          # Dependencies
├── Rakefile                         # Build and test tasks
├── README.md                        # Documentation
├── CHANGELOG.md                     # Version history
├── MIT-LICENSE                      # License file
└── .rubocop.yml                     # Code style configuration
```

## Development Workflow

### 1. Jira Integration with MCP Server

When a Jira ID is provided in tasks:

1. **Fetch Jira Issue Details**: Use the `atlassian-mcp-server` MCP server to fetch Jira issue details
   ```
   Use the mcp_atlassian-mcp_getJiraIssue tool with:
   - cloudId: Use mcp_atlassian-mcp_getAccessibleAtlassianResources to get the cloud ID first
   - issueIdOrKey: The provided Jira ID
   ```

2. **Read and Analyze**: Carefully read the story description, acceptance criteria, and any technical requirements

3. **Plan Implementation**: Break down the task into actionable steps based on the Jira requirements

### 2. Implementation Standards

#### Code Quality Requirements
- **Test Coverage**: Maintain > 80% test coverage at all times
- **Code Style**: Follow Cookstyle standards (runs on CI via `cookstyle --chefstyle -c .rubocop.yml`)
- **Ruby Version**: Support Ruby 3.1+ as specified in gemspec
- **Dependencies**: Use only approved dependencies listed in gemspec

#### Testing Requirements
- Write comprehensive unit tests for all new functionality
- Use RSpec for testing framework
- Place tests in appropriate `spec/` subdirectories matching `lib/` structure
- Run tests with: `bundle exec rake spec`
- Coverage reports generated via SimpleCov and Coveralls

### 3. DCO Compliance

**All commits MUST be signed off for Developer Certificate of Origin (DCO) compliance.**

#### DCO Requirements:
- Every commit must include a `Signed-off-by` line
- Use: `git commit -s -m "Your commit message"`
- The sign-off certifies you have the right to submit the code under the project's license
- Format: `Signed-off-by: Your Name <your.email@example.com>`

#### Example DCO-compliant commit:
```bash
git commit -s -m "Add XML namespace support for nested hashes

This implementation adds support for XML namespaces in nested hash
structures as requested in JIRA-1234.

Signed-off-by: Developer Name <dev@example.com>"
```

### 4. GitHub Workflows and CI/CD

The repository uses GitHub Actions workflows:

#### CI Pipeline (`ci.yml`):
- **Trigger**: Push to master, all PRs
- **Ruby Versions**: 3.1, 3.4
- **Steps**: Checkout → Setup Ruby → Bundle install → Run tests
- **Coverage**: Coveralls integration for coverage reporting

#### Linting (`lint.yml`):
- **Trigger**: PRs and push to main
- **Tool**: Cookstyle with Chef style guide
- **Configuration**: Uses `.rubocop.yml`
- **Problem Matchers**: Shows failures directly in PR

### 5. Available GitHub Labels

Use these labels when creating PRs or issues:

| Label | Description | Use Case |
|-------|-------------|----------|
| `bug` | Something isn't working | Bug fixes and error corrections |
| `documentation` | Improvements or additions to documentation | README updates, code comments |
| `duplicate` | This issue or pull request already exists | Mark duplicates |
| `enhancement` | New feature or request | New features and improvements |
| `good first issue` | Good for newcomers | Beginner-friendly tasks |
| `help wanted` | Extra attention is needed | Complex issues needing collaboration |
| `invalid` | This doesn't seem right | Invalid or malformed issues |
| `oss-standards` | Related to OSS Repository Standardization | Chef OSS compliance work |
| `question` | Further information is requested | Clarifications needed |
| `wontfix` | This will not be worked on | Rejected changes |

### 6. Pull Request Workflow

#### Branch Creation and PR Process:
1. **Branch Naming**: Use the Jira ID as the branch name (e.g., `CHEF-1234`)
2. **Create Branch**: 
   ```bash
   git checkout -b CHEF-1234
   ```
3. **Make Changes**: Implement the required functionality
4. **Commit with DCO**: 
   ```bash
   git commit -s -m "Your detailed commit message"
   ```
5. **Push Branch**:
   ```bash
   git push origin CHEF-1234
   ```
6. **Create PR using GH CLI**:
   ```bash
   gh pr create --title "CHEF-1234: Brief description" --body "$(cat pr_description.html)"
   ```

#### PR Description Format:
Use Markdown formatting for PR descriptions:

```markdown
## Summary
Brief description of changes made.

## Changes Made
- Added XML namespace support for nested hashes
- Updated hash conversion logic in `lib/chef-gyoku/hash.rb`
- Added comprehensive test coverage in `spec/chef-gyoku/hash_spec.rb`

## Testing
- All existing tests pass
- New tests added for namespace functionality
- Coverage maintained above 80%

## Jira Issue
Resolves: [CHEF-1234](https://issues.chef.io/browse/CHEF-1234)

## DCO
All commits signed off with DCO compliance.

This work was completed with AI assistance following Progress AI policies.
```

### 7. Prompt-Based Development Process

#### Step-by-Step Workflow:
All tasks should follow this prompt-based approach:

1. **Initial Analysis**
   - Read Jira issue (if provided)
   - Analyze requirements
   - **Prompt**: "I have analyzed the requirements. The task involves [brief description]. Should I proceed with planning the implementation?"

2. **Implementation Planning**
   - Break down into subtasks
   - Identify files to modify/create
   - Plan test strategy
   - **Prompt**: "I have created an implementation plan with [X] steps: [list steps]. Should I proceed with step 1: [first step]?"

3. **Step-by-Step Implementation**
   - Complete one logical unit at a time
   - After each step: **Prompt**: "Step [N] completed: [what was done]. Next step is: [next step description]. Should I continue with the next step?"

4. **Testing Phase**
   - Write/update tests
   - Verify coverage
   - **Prompt**: "Implementation completed. Tests written and coverage verified at [X]%. Should I proceed with creating the PR?"

5. **PR Creation**
   - Create branch using Jira ID
   - Commit with DCO
   - Create PR with HTML description
   - **Prompt**: "PR created successfully: [PR link]. All tasks completed. Is there anything else you'd like me to do?"

#### Confirmation Requirements:
- Always ask for confirmation before proceeding to the next major step
- Provide clear summaries of what was accomplished
- Indicate remaining steps in the workflow
- Wait for explicit approval before continuing

### 8. Files and Areas to Avoid Modifying

**DO NOT MODIFY** these files without explicit approval:
- `.github/workflows/` (CI/CD configurations)
- `chef-gyoku.gemspec` (gem specification)
- `Gemfile` (dependencies)
- `.rubocop.yml` (style configuration)
- `MIT-LICENSE` (license file)
- Version files without proper versioning strategy

### 9. Testing and Quality Assurance

#### Before Creating PR:
1. **Run Full Test Suite**:
   ```bash
   bundle exec rake spec
   ```
2. **Check Code Style**:
   ```bash
   bundle exec rake style
   ```
3. **Verify Coverage**: Ensure coverage remains > 80%
4. **Manual Testing**: Test the specific functionality implemented

#### Test Structure:
- Unit tests for all public methods
- Edge case testing for XML generation
- Integration tests for complex scenarios
- Performance tests for large data structures (when applicable)

### 10. Additional Considerations

#### Ruby-Specific Guidelines:
- Follow Ruby best practices and idioms
- Use appropriate Ruby stdlib methods
- Consider backward compatibility with supported Ruby versions
- Handle encoding properly for XML generation

#### XML Processing Guidelines:
- Validate XML output format
- Handle special characters and escaping
- Test namespace support thoroughly
- Consider XML schema compliance where applicable

#### Documentation Updates:
- Update README.md for new features
- Add inline code documentation
- Update CHANGELOG.md following semantic versioning
- Include usage examples for complex features

## AI-Assisted Development & Compliance

- ✅ Create PR with `ai-assisted` label (if label doesn't exist, create it with description "Work completed with AI assistance following Progress AI policies" and color "9A4DFF")
- ✅ Include "This work was completed with AI assistance following Progress AI policies" in PR description

### Jira Ticket Updates (MANDATORY)

- ✅ **IMMEDIATELY after PR creation**: Update Jira ticket custom field `customfield_11170` ("Does this Work Include AI Assisted Code?") to "Yes"
- ✅ Use atlassian-mcp tools to update the Jira field programmatically
- ✅ **CRITICAL**: Use correct field format: `{"customfield_11170": {"value": "Yes"}}`
- ✅ Verify the field update was successful

### Documentation Requirements

- ✅ Reference AI assistance in commit messages where appropriate
- ✅ Document any AI-generated code patterns or approaches in PR description
- ✅ Maintain transparency about which parts were AI-assisted vs manual implementation

### Workflow Integration

This AI compliance checklist should be integrated into the main development workflow Step 4 (Pull Request Creation):

```
Step 4: Pull Request Creation & AI Compliance
- Step 4.1: Create branch and commit changes WITH SIGNED-OFF COMMITS
- Step 4.2: Push changes to remote
- Step 4.3: Create PR with ai-assisted label
- Step 4.4: IMMEDIATELY update Jira customfield_11170 to "Yes"
- Step 4.5: Verify both PR labels and Jira field are properly set
- Step 4.6: Provide complete summary including AI compliance confirmation
```

- **Never skip Jira field updates** - This is required for Progress AI governance
- **Always verify updates succeeded** - Check response from atlassian-mcp tools
- **Treat as atomic operation** - PR creation and Jira updates should happen together
- **Double-check before final summary** - Confirm all AI compliance items are completed

### Audit Trail

All AI-assisted work must be traceable through:

1. GitHub PR labels (`ai-assisted`)
2. Jira custom field (`customfield_11170` = "Yes")
3. PR descriptions mentioning AI assistance
4. Commit messages where relevant

---

This workflow ensures consistent, high-quality contributions to the chef-gyoku repository while maintaining compliance with Chef's development standards and processes.

Remember to always ask for confirmation before proceeding to the next step, and provide clear summaries of completed work and remaining tasks.