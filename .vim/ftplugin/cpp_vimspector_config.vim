let g:vimspector_config = {
	\ 'launch':{
		\ 'adapter': 'CodeLLDB',
		\ 'filetypes': ['cpp', 'c', 'objc', 'rust'],
		\ 'configuration':{
			\ 'name': 'launch',
			\ 'request': 'launch',
			\ 'program': '${workspaceRoot}/a.out',
			\ 'args': [],
			\ 'cwd': '${workspaceRoot}',
			\ 'environment': [],
			\ 'externalConsole': v:true,
			\ 'MIMode': 'lldb',
			\ 'breakpointers': {
				\ 'exception': {
					\ 'cpp_throw': 'Y',
					\ 'cpp_catch': 'N'
				  \ }
			  \ }
		  \ }
	  \ },
	  \ 'attach': {
		\ 'adapter': 'CodeLLDB',
		\ 'filetypes': ['cpp', 'c', 'objc', 'rust'],
		\ 'configuration':{
			\ 'name': 'attach',
			\ 'type': 'cppdbg',
			\ 'request': 'attach',
			\ 'program': '${workspaceRoot}/a.out',
			\ 'MIMode': 'lldb',
			\ 'breakpointers':{
				\ 'exception':{
					\ 'cpp_throw': 'Y',
					\ 'cpp_catch': 'N'
				  \ }
			  \ }
		  \ }
	  \ }
  \ }
