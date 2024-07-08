=<  $%  [%get-models res=get-models]
        [%list-assistants res=list-assistants]
    ::
        [%create-thread res=create-thread]
        [%retrieve-thread res=retrieve-thread]
        [%delete-thread res=delete-thread]
    ::
        [%create-message res=create-message]
        [%list-messages res=list-messages]
        [%retrieve-message res=retrieve-message]
    ::
        [%create-run res=create-run]
        [%list-runs res=list-runs]
        [%list-run-steps res=list-run-steps]
        [%retrieve-run res=retrieve-run]
        [%retrieve-run-step res=retrieve-run-step]
        [%submit-tool-output res=submit-tool-output]
    ==
::
|%
::
+$  get-models
  json
::
+$  list-assistants
  (list assistant)
::
+$  create-thread
  thread
::
+$  retrieve-thread
  thread
::
+$  delete-thread
  $:  thread-id=@t
      object=@t
      deleted=?
  ==
::
+$  create-message
  message
::
+$  list-messages
  (list message)
::
+$  retrieve-message
  message
::
+$  create-run
  run
::
+$  list-runs
  (list run)
::
+$  list-run-steps
  (list run-step)
::
+$  retrieve-run
  run
::
+$  retrieve-run-step
  run-step
::
+$  submit-tool-output
  run
::
::  ::  ::  ::  ::  ::  ::
+$  error
  $:  message=@t
      param=~
      code=~
  ==
::
+$  assistant
  $:  assistant-id=@t
      created-at=@da
      name=@t
      model=@t
  ==
::
+$  thread
  $:  thread-id=@t
      object=@t
      created-at=@da
  ==
::
+$  message-content
  $%  [%text value=@t]
  ==
::
+$  message
  $:  message-id=@t
      object=@t
      created-at=@da
      thread-id=@t
      role=@t
      content=(list message-content)
      assistant-id=(unit @t)
      run-id=(unit @t)
::      file-ids=(list @t)
  ==
::
+$  run-status
  $?  %queued
      %'in_progress'
      %'requires_action'
      %cancelling
      %cancelled
      %failed
      %completed
      %expired
  ==
::
+$  tool-call
  $:  id=@t
      type=@t
      function=[name=@t args=@t]
  ==
::
+$  required-action
  $:  type=@t
      submit-tool-outputs=(list tool-call)
  ==
::
+$  run-error
  $:  code=@t
      message=@t
  ==
::
+$  run
  $:  required-action=(unit required-action)
      run-id=@t
      object=@t
      created-at=@da
      thread-id=@t
      assistant-id=@t
      status=run-status
      last-error=(unit run-error)
      expires-at=(unit @da)
      started-at=(unit @da)
      cancelled-at=(unit @da)
      failed-at=(unit @da)
      completed-at=(unit @da)
  ==
::
+$  run-step-status
  $?  %'in_progress'
      %cancelled
      %failed
      %completed
      %expired
  ==
::
+$  step-details
  $%  [%message-creation id=@t]
      [%tool-calls p=(list step-tool-call)]
  ==
::
+$  step-tool-call
  $%  [%code-interpreter id=@t]
      [%retrieval id=@t]
      [%function id=@t name=@t args=@t output=(unit @t)]
  ==
::
+$  run-step
  $:  =step-details
      id=@t
      object=@t
      created-at=@da
      assistant-id=@t
      thread-id=@t
      run-id=@t
      type=@t
      status=run-step-status
      last-error=(unit run-error)
      expires-at=(unit @da)
      cancelled-at=(unit @da)
      failed-at=(unit @da)
      completed-at=(unit @da)
  ==
::
--
