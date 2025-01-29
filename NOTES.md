# Development

## Naming Conventions

Regarding all resource identifiers and API names intended for public consumption:

- All publicly exposed library names (including Swift packages) associated with the Super Swift Markup projects, should begin with the long-form initialism `SSM` (for Super Swift Markup).
    - Unless the `SSM` prefix is directly following by another `M` like e.g. `SSMMarkdown` in which case the `SS` prefix should be preferred such that the resulting name is `SSMarkdown` as opposed to `SSMMarkdown`.

- At the source-code level, all publicly exposed identifiers (including those for classes, structures and enumerations) should begin with the shortened `SS` prefix (which is easy to type via my left hand in just two keystrokes). 

For internally scoped definitions, short descriptive names with no `SSM` or `SS` prefix are preferable, unless such coincides with commonly used APIs from system frameworks.

# Miscellaneous

- Use [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) formatting when applicable. 
