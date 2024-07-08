=<  $%  [%get-models req=get-models]
        [%list-assistants req=list-assistants]
    ::
        [%create-thread req=create-thread]
        [%retrieve-thread req=retrieve-thread]
        [%delete-thread req=delete-thread]
    ::
        [%create-message req=create-message]
        [%list-messages req=list-messages]
        [%retrieve-message req=retrieve-message]
    ::
        [%create-run req=create-run]
        [%list-runs req=list-runs]
        [%list-run-steps req=list-run-steps]
        [%retrieve-run req=retrieve-run]
        [%retrieve-run-step req=retrieve-run-step]
        [%submit-tool-output req=submit-tool-output]
    ==
::
|%
::
+$  get-models
  ~
::
+$  list-assistants
  ~
::
+$  create-thread-message
  $:  role=@t
      content=@t
      file-ids=(list @t)
  ==
+$  create-thread
  $:  messages=(list create-thread-message)
  ==
::
+$  retrieve-thread
  $:  thread-id=@t
  ==
::
+$  delete-thread
  $:  thread-id=@t
  ==
::
+$  create-message
  $:  thread-id=@t
      role=@t
      content=@t
      file-ids=(list @t)
  ==
::
+$  list-messages
  $:  thread-id=@t
  ==
::
+$  retrieve-message
  $:  thread-id=@t
      message-id=@t
  ==
::
+$  create-run
  $:  thread-id=@t
      assistant-id=@t
  ==
::
+$  list-runs
  $:  thread-id=@t
  ==
::
+$  list-run-steps
  $:  thread-id=@t
      run-id=@t
  ==
::
+$  retrieve-run
  $:  thread-id=@t
      run-id=@t
  ==
::
+$  retrieve-run-step
  $:  thread-id=@t
      run-id=@t
      step-id=@t
  ==
::
+$  submit-tool-output
  $:  thread-id=@t
      run-id=@t
      call-id=@t
      output=@t
  ==
::
--
