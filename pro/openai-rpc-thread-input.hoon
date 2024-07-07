/@  openai-rpc-req-get-models
/@  openai-rpc-req-list-assistants
/@  openai-rpc-req-create-thread
/@  openai-rpc-req-retrieve-thread
/@  openai-rpc-req-delete-thread
/@  openai-rpc-req-create-message
/@  openai-rpc-req-list-messages
/@  openai-rpc-req-retrieve-message
/@  openai-rpc-req-create-run
/@  openai-rpc-req-list-runs
/@  openai-rpc-req-list-run-steps
/@  openai-rpc-req-retrieve-run
/@  openai-rpc-req-retrieve-run-step
/@  openai-rpc-req-submit-tool-output
::
$%  [%get-models req=openai-rpc-req-get-models]
    [%list-assistants req=openai-rpc-req-list-assistants]
::
    [%create-thread req=openai-rpc-req-create-thread]
    [%retrieve-thread req=openai-rpc-req-retrieve-thread]
    [%delete-thread req=openai-rpc-req-delete-thread]
::
    [%create-message req=openai-rpc-req-create-message]
    [%list-messages req=openai-rpc-req-list-messages]
    [%retrieve-message req=openai-rpc-req-retrieve-message]
::
    [%create-run req=openai-rpc-req-create-run]
    [%list-runs req=openai-rpc-req-list-runs]
    [%list-run-steps req=openai-rpc-req-list-run-steps]
    [%retrieve-run req=openai-rpc-req-retrieve-run]
    [%retrieve-run-step req=openai-rpc-req-retrieve-run-step]
    [%submit-tool-output req=openai-rpc-req-submit-tool-output]
==
