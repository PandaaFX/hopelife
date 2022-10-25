const AutoGitUpdate = require('auto-git-update');

const config = {
    repository: 'https://github.com/PandaaFX/hopelife',
    token: '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',
    tempLocation: 'C:/Users/Administrator/Desktop/pandaatmp/',
    branch: 'main',
    fromReleases: false,
    exitOnComplete: true
}

const updater = new AutoGitUpdate(config);

updater.forceUpdate();