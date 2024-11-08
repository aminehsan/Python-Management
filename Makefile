PYTHON_NAME = python
PIP_NAME = pip
VIRTUAL_ENVIRONMENT_NAME = .venv
ENTRY_POINT_START = main.py
REQUIREMENTS_FILE_NAME = requirements.txt
#
CUSTOMIZE_EXECUTABLE_COMMAND = \
	echo 'run command 1' \
	echo 'run command 2' \


### Execute Customize Command
execute_command:
	$(CUSTOMIZE_EXECUTABLE_COMMAND)


### Setup Virtual Environment
windows_setup:
	if not exist $(VIRTUAL_ENVIRONMENT_NAME) \
	$(PYTHON_NAME) --version && $(PYTHON_NAME) -m venv $(VIRTUAL_ENVIRONMENT_NAME)
#
unix_setup:
	test -d $(VIRTUAL_ENVIRONMENT_NAME) || \
	$(PYTHON_NAME) --version && $(PYTHON_NAME) -m venv $(VIRTUAL_ENVIRONMENT_NAME)


### Install Requirements Packages
windows_install:
	if exist $(VIRTUAL_ENVIRONMENT_NAME) \
	$(VIRTUAL_ENVIRONMENT_NAME)\Scripts\$(PYTHON_NAME) -m pip install --upgrade pip && \
	$(VIRTUAL_ENVIRONMENT_NAME)\Scripts\$(PIP_NAME) install -r $(REQUIREMENTS_FILE_NAME) && \
	$(VIRTUAL_ENVIRONMENT_NAME)\Scripts\$(PYTHON_NAME) -m pipdeptree
#
unix_install:
	test -d $(VIRTUAL_ENVIRONMENT_NAME) && \
	$(VIRTUAL_ENVIRONMENT_NAME)/bin/$(PYTHON_NAME) -m pip install --upgrade pip && \
	$(VIRTUAL_ENVIRONMENT_NAME)/bin/$(PIP_NAME) install -r $(REQUIREMENTS_FILE_NAME) && \
	$(VIRTUAL_ENVIRONMENT_NAME)/bin/$(PYTHON_NAME) -m pipdeptree


### Show Installed Packages
windows_show_packages:
	if exist $(VIRTUAL_ENVIRONMENT_NAME) \
	$(VIRTUAL_ENVIRONMENT_NAME)\Scripts\$(PYTHON_NAME) -m pipdeptree
#
unix_show_packages:
	test -d $(VIRTUAL_ENVIRONMENT_NAME) && \
	$(VIRTUAL_ENVIRONMENT_NAME)/bin/$(PYTHON_NAME) -m pipdeptree


### Run Current Service
windows_run:
	if exist $(VIRTUAL_ENVIRONMENT_NAME) \
	$(VIRTUAL_ENVIRONMENT_NAME)\Scripts\$(PYTHON_NAME) $(ENTRY_POINT_START)
#
unix_run:
	test -d $(VIRTUAL_ENVIRONMENT_NAME) && \
	$(VIRTUAL_ENVIRONMENT_NAME)/bin/$(PYTHON_NAME) $(ENTRY_POINT_START)


### Debug Current Service
windows_debug:
	if exist $(VIRTUAL_ENVIRONMENT_NAME) \
	$(VIRTUAL_ENVIRONMENT_NAME)\Scripts\$(PYTHON_NAME) -m pdb $(ENTRY_POINT_START)
#
unix_debug:
	test -d $(VIRTUAL_ENVIRONMENT_NAME) && \
	$(VIRTUAL_ENVIRONMENT_NAME)/bin/$(PYTHON_NAME) -m pdb $(ENTRY_POINT_START)


### Uninstall Virtual Environment
windows_uninstall:
	if exist $(VIRTUAL_ENVIRONMENT_NAME) \
	rmdir /s /q $(VIRTUAL_ENVIRONMENT_NAME)
#
unix_uninstall:
	test -d $(VIRTUAL_ENVIRONMENT_NAME) && \
	rm -rf $(VIRTUAL_ENVIRONMENT_NAME)
