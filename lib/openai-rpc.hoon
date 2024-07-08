|%
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
++  dejs
  =,  dejs:format
  |%
  ++  thread
    ^-  $-(json ^thread)
    (ot id+so object+so %'created_at'^du ~)
::
  ++  message
    ^-  $-(json ^message)
    %-  ot
    :~  id+so
        object+so
        %'created_at'^du
        %'thread_id'^so
        role+so
        content+(ar message-content)
        %'assistant_id'^(mu so)
        %'run_id'^(mu so)
::        %'file_ids'^(ar so)
    ==
::
  ++  message-content  :: TODO: complete structure
    |=  =json
    ^-  ^message-content
    ?>  ?=(%o -.json)
    =/  text  (~(got by p.json) 'text')
    ?>  ?=(%o -.text)
    =/  value  (~(got by p.text) 'value')
    ?>  ?=(%s -.value)
    [%text p.value]
::
  ++  assistant
    %-  ot
    :~  id+so
        %'created_at'^du
        name+so
        model+so
    ==
::
  ++  run-status
    |=  =json
    ^-  ^run-status
    ?>  ?=(%s -.json)
    ?>  ?=(^run-status p.json)
    p.json
::
  ++  tool-call
    %-  ot
    :~  id+so
        type+so
        function+(ot name+so arguments+so ~)
    ==
::
  ++  required-action
    |=  =json
    ^-  (unit ^required-action)
    ?~  json  ~
    ?.  ?=(%o -.json)
      ~
    =/  typ  (~(got by p.json) 'type')
    =/  sto  (~(got by p.json) 'submit_tool_outputs')
    ?.  ?=(%s -.typ)  ~
    ?.  ?=(%o -.sto)  ~
    =/  tcs  (~(get by p.sto) 'tool_calls')
    ?~  tcs  ~
    `[p.typ ((ar tool-call) u.tcs)]
::
  ++  run-error  (ot code+so message+so ~)
::
  ++  run
    |=  =json
    ^-  ^^run
    =/  result
      %.  json
      %-  ot
      :~  id+so
          object+so
          %'created_at'^du
          %'thread_id'^so
          %'assistant_id'^so
          status+run-status
          %'last_error'^(mu run-error)
          %'expires_at'^(mu du)
          %'started_at'^(mu du)
          %'cancelled_at'^(mu du)
          %'failed_at'^(mu du)
          %'completed_at'^(mu du)
      ==
    ?>  ?=(%o -.json)
    =/  req-act=(unit ^required-action)
      ?~  a=(~(get by p.json) %'required_action')  ~
      (required-action u.a)
    [req-act result]
::
  ++  run-step-status
    |=  =json
    ^-  ^run-step-status
    ?>  ?=(%s -.json)
    ?>  ?=(^run-step-status p.json)
    p.json
::
  ++  run-step
    |=  =json
    ^-  ^run-step
    =/  result
      %.  json
      %-  ot
      :~  id+so
          object+so
          %'created_at'^du
          %'assistant_id'^so
          %'thread_id'^so
          %'run_id'^so
          type+so
          status+run-step-status
          %'last_error'^(mu run-error)
          %'expires_at'^(mu du)
          %'cancelled_at'^(mu du)
          %'failed_at'^(mu du)
          %'completed_at'^(mu du)
      ==
    ?>  ?=(%o -.json)
    =/  sd  (~(got by p.json) 'step_details')
    ?>  ?=(%o -.sd)
    =/  typ  (~(got by p.sd) 'type')
    ?>  ?=(%s -.typ)
    =/  =step-details
      ?:  =(p.typ 'message_creation')
        =/  mc  (~(got by p.sd) 'message_creation')
        ?>  ?=(%o -.mc)
        =/  id  (~(got by p.mc) 'message_id')
        ?>  ?=(%s -.id)
        [%message-creation p.id]
      ?>  =(p.typ 'tool_calls')
      =/  tc  (~(got by p.sd) 'tool_calls')
      [%tool-calls ((ar step-tool-call) tc)]
    [step-details result]
::
  ++  step-tool-call
    |=  =json
    ^-  ^step-tool-call
    ?>  ?=(%o -.json)
    =/  typ  (~(got by p.json) 'type')
    ?>  ?=(%s -.typ)
    =/  id  (~(got by p.json) 'id')
    ?>  ?=(%s -.id)
    ?+  p.typ  !!
        %'code_interpreter'  [%code-interpreter p.id]
        %retrieval           [%retrieval p.id]
        %function
      =/  func  (~(got by p.json) 'function')
      ?>  ?=(%o -.func)
      =/  name  (~(got by p.func) 'name')
      =/  args  (~(got by p.func) 'arguments')
      =/  output  (~(got by p.func) 'output')
      =/  out=(unit @t)
        ?~  output  ~
        ?>  ?=(%s -.output)
        `p.output
      ?>  ?=(%s -.name)
      ?>  ?=(%s -.args)
      :*  %function
          p.id
          p.name
          p.args
          out
      ==
    ==
  --
--
