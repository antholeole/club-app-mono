module.exports = {
    extends: ["some-other-base-config", "monorepo"],
    rules: {
        "scope-enum": [
            2,
            "always",
            [
                "root",
                "flutter",
                "worker",
                "hasura",
                "knowledge",
                "website"
            ],
        ],
    },
};