# ``rebase``

A practical guide to mastering Git interactive rebase through hands-on exercises.

## Overview

This workshop teaches you how to clean up Git history using interactive rebase. You'll learn to rewrite commits so that each one builds, passes tests, and represents a meaningful unit of work—essential skills for maintaining a professional, debuggable codebase.

## Getting Started

### Setup

1. **Fork this repository** to your own GitHub account
2. **Clone your fork** locally
3. **Check out the task branch**:
   ```
   git checkout task/build-calculator
   ```

### Your Task

The `task/build-calculator` branch contains a calculator implementation with a messy commit history:
- Some commits don't build (compilation errors)
- Some commits have failing tests
- Some commits are incomplete or have unclear messages
- Work is scattered across too many small commits

**Your mission:** Use interactive rebase to rewrite the history so that:

1. ✅ **Each commit builds** - no compilation errors at any point
2. ✅ **Each commit has passing tests** - all tests pass at every commit
3. ✅ **Each commit is a meaningful unit of work** - related changes grouped logically with clear, descriptive messages

### Running the Rebase

Start an interactive rebase from the main branch:

```
git rebase -i main
```

This opens your editor with a list of commits. Edit the file to reorganize them using the commands described below.

### Pushing Your Changes

Once you've cleaned up the history locally, you can push to your fork (remember: **never push to the original repository**):

```
git push origin task/build-calculator --force-with-lease --force-if-includes
```

**What these flags do:**
- `--force-with-lease`: Safely overwrites remote history only if no one else has pushed new commits since you last fetched. Prevents accidentally deleting teammates' work.
- `--force-if-includes`: Adds an extra safety check—verifies that all commits you're pushing are based on commits already on the remote, preventing accidental data loss from conflicting rebases.

Together, they provide a safer alternative to `--force`, protecting you from common mistakes when rewriting history.

---

## Interactive Rebase: A Practical Guide

Interactive rebase allows you to edit, reorder, combine, and split commits before merging. It's invoked with:

```
git rebase -i <base-commit>
```

Your editor opens with a list of commits and available commands. Here are the most useful ones:

### Key Commands

| Command | Action | Use Case |
|---------|--------|----------|
| `pick` or `p` | Use the commit as-is | Default; keep the commit unchanged |
| `reword` or `r` | Use commit but change message | Fix bad commit messages (e.g., "wip" → descriptive message) |
| `squash` or `s` | Combine with previous commit, keep both messages | Consolidate related small fixes into a logical commit |
| `fixup` or `f` | Combine with previous commit, discard this message | Merge WIP or "oops" commits without cluttering the message |
| `edit` or `e` | Stop during rebase to modify the commit | Split a commit into multiple logical pieces |
| `drop` or `d` | Remove the commit entirely | Eliminate placeholder or broken commits |

### Example Workflow

If your commit list looks like:
```
pick abc123 Add multiplication method
pick def456 Oops forgot semicolon
pick ghi789 Add test for multiplication
pick jkl012 Fix multiplication logic
```

You could clean this up by marking the "oops" commit as `fixup`:
```
pick abc123 Add multiplication method
fixup def456 Oops forgot semicolon
pick ghi789 Add test for multiplication
squash jkl012 Fix multiplication logic
```

This results in a clean history with just two meaningful commits:
1. One for adding multiplication with all fixes included
2. One for the test

**New git history after rebase:**
```
abc123 Add multiplication method (with fixes)
ghi789 Add test for multiplication
```

**Further cleanup opportunity:** If the multiplication feature wasn't too large, you could simplify this even further by combining both commits into a single, well-tested commit:

```
pick abc123 Add multiplication method
squash ghi789 Add test for multiplication
```

This results in one comprehensive, tested commit:
```
abc123 Add multiplication method with comprehensive tests
```

This approach works well for smaller, focused changes. For larger changes with multiple logical components, keeping them separate makes the history more navigable.

### Using HEAD~ Syntax

Instead of always rebasing from the parent branch, you can use `HEAD~` to rebase the last N commits:

```
git rebase -i HEAD~4
```

This rebases the last 4 commits, opening your editor with those commits available for editing.

**Examples:**
- `git rebase -i HEAD~3` - Rebase the last 3 commits
- `git rebase -i HEAD~7` - Rebase the last 7 commits
- `git rebase -i HEAD~1` - Edit just the most recent commit (useful for amending messages)

**Common scenario:** You've made 5 commits on your feature branch and want to clean them up before merging:

```bash
git rebase -i HEAD~5
```

Edit the commands, save, and Git will rebase those 5 commits according to your instructions. This is often faster and clearer than rebasing from main, especially when working locally.

---

## The Theory & Benefits of Rebasing

### The Problem with Messy History

As you develop features, you naturally create commits that aren't ready for the main branch:

- **Non-building commits** - WIPs or incomplete work you're saving
- **Failing test commits** - Placeholders with broken tests
- **Trivial "oops" commits** - Quick fixes for typos or formatting
- **Unclear messages** - Generic messages like "fix stuff" or "wip"

This creates a **tangled, unstable history** that haunts your team later.

### Why Unclean History Is Painful

#### Debugging Live Issues
When a bug appears in production, you need to find the offending commit. With a messy history full of non-building commits and unclear messages:
- You manually scan dozens of tiny, meaningless commits
- It's unclear which commit actually introduced the bug
- Identifying the breaking change becomes laborious and error-prone

#### Losing Git Bisect's Power
`git bisect` is a powerful debugging tool that uses binary search to find the exact commit that introduced a bug. **But it only works if every commit is buildable and has passing tests.**

When bisect checks out a non-building or failing-test commit during its search, it fails immediately because:
- The code won't compile
- Tests won't run
- You're forced to manually investigate instead of automating the search

#### Poor Context for Future Work
- Bad commit messages provide zero context to anyone (including you) reviewing history later
- "Future you" is left trying to figure out what the commit was actually about
- Code reviews become harder to follow
- Understanding the progression of a feature becomes impossible

### Why Rebasing Solves This

Rebasing lets you **take all your WIPs, placeholders, and interim commits and combine them into clean, meaningful commits** ready for merging.

#### Benefits

**1. A Stable, Debuggable History**
- Every commit on main is buildable and testable
- `git bisect` becomes reliable and fast
- Debugging production issues becomes manageable

**2. Clear, Understandable Progression**
- Each commit represents one logical unit of work
- Commit messages tell a story of how the feature developed
- Code reviews are easier to follow
- Future developers (including you) can understand the reasoning behind changes

**3. Better Collaboration**
- Clean history makes it easier to cherry-pick or revert specific changes if needed
- Team members can understand what happened and why
- Merge conflicts are easier to understand and resolve

**4. Professional Codebase**
- A well-maintained Git history reflects code quality
- It shows attention to detail and respect for team workflow
- It makes the codebase more maintainable long-term

### Best Practice

**Before merging a feature branch to main:**
1. Ensure every commit builds
2. Ensure every commit has passing tests
3. Group related changes into logical units
4. Write clear, descriptive commit messages
5. Push to your fork with `--force-with-lease --force-if-includes`

This practice keeps the main branch clean, stable, and debuggable—a cornerstone of professional software development.

### Resources
- Atlassian Intro to [rebase](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase)
- Git [Manual](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History#_interactive_rebase)
