let project = new Project('New Project');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources');
project.addLibrary('Entities');
project.addLibrary('Input');
project.addLibrary('Camera');
resolve(project);
