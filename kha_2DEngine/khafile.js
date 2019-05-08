let project = new Project('New Project');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources');
project.addLibrary('khaEngine2D');
project.addLibrary('zui');
resolve(project);
