MODULE Utilities
    !*******************************************************************************************************************************************************************************
    !NAME          : Donovan Kennedy     
    !Date          : January 18, 2023
    !Robot         : Robot 7 - IRB1200 Servo Gripper
    !Description   : This module is used to store common procedures for use with various modules
    !                
    !*******************************************************************************************************************************************************************************

    ! Variables Declarations

    !Variable to set the value of gripper opening position (Not Less Than 0). Gripper opened to 85mm
    VAR num Gripper_Open_Pos:=0;

    !Variable to set the gripper closing position (255 Max). Gripper closed.    
    VAR Num Gripper_Close_Pos:=249;

    !Variable to check gripper is open or closed
    VAR num GripperClosed;

    PROC Close_Gripper()
        !*******************************************************************************************************************************************************
        !Procedure : Close_Gripper
        !Purpose   : This procedure will close the gripper to the value set in NUM Gripper_Close_Pos.
        !*******************************************************************************************************************************************************

        !Gripper action to set gripper into run mode and to activate it
        SetGo GO_GripperAction,9;

        WaitTime 0.25;

        !To set the gripper position to close
        SetGO GO_GripperPosition,Gripper_Close_Pos;
        WaitGI GI_GripperPositionFB,Gripper_Close_Pos;

        GripperClosed:=1;

    ENDPROC

    PROC Open_Gripper()
        !*******************************************************************************************************************************************************
        !Procedure : Open_Gripper
        !Purpose   : This procedure will open the gripper to the value set in NUM Gripper_Open_Pos.
        !*******************************************************************************************************************************************************

        !Gripper action to set gripper into run mode and to activate it
        SetGo GO_GripperAction,9;
        WaitTime 0.5;

        !To set the gripper position to open
        SetGO GO_GripperPosition,Gripper_Open_Pos;
        

    ENDPROC

ENDMODULE