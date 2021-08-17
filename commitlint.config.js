module.exports = {
    extends: ["@commitlint/config-conventional", "monorepo"],
    rules: {
        "scope-enum": [
            2,
            "always",
            [
                "root",
                "flutter",
                "worker",
                "infra-mocks",
                "hasura",
                "knowledge",
                "website",
                "multi"
            ],
        ],
    },
};