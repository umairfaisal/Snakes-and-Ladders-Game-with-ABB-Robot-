MODULE SnakesAndLadders

    !**************************************************************************
    !ROBTARGET DECLARATIONS
    !**************************************************************************
    VAR robtarget CurrentPickPosP1;
    VAR robtarget CurrentAbovePickPosP1;
    VAR robtarget CurrentPickPosP2;
    VAR robtarget CurrentAbovePickPosP2;

    VAR robtarget OldPickPosP1;
    VAR robtarget OldAbovePickPosP1;
    VAR robtarget OldPickPosP2;
    VAR robtarget OldAbovePickPosP2;

    !ROBTARGETS ARRAYS
    CONST robtarget PickPositions{60}:=[Position00,Position1,Position2,Position3,Position4,Position5,Position6,Position7,Position8,Position9,Position10,Position11,Position12,Position13,Position14,Position15,Position16,Position17,Position18,Position19,Position20,Position21,Position22,Position23,Position24,Position25,Position26,Position27,Position28,Position29,Position30,Position31,Position32,Position33,Position34,Position35,Position36,Position37,Position38,Position39,Position40,Position41,Position42,Position43,Position44,Position45,Position46,Position47,Position48,Position49,Position50,WinnerPos,WinnerPos,WinnerPos,WinnerPos,WinnerPos,WinnerPos,WinnerPos,WinnerPos,WinnerPos];
    CONST robtarget AbovePickPositions{60}:=[AbovePosition00,AbovePosition1,AbovePosition2,AbovePosition3,AbovePosition4,AbovePosition5,AbovePosition6,AbovePosition7,AbovePosition8,AbovePosition9,AbovePosition10,AbovePosition11,AbovePosition12,AbovePosition13,AbovePosition14,AbovePosition15,AbovePosition16,AbovePosition17,AbovePosition18,AbovePosition19,AbovePosition20,AbovePosition21,AbovePosition22,AbovePosition23,AbovePosition24,AbovePosition25,AbovePosition26,AbovePosition27,AbovePosition28,AbovePosition29,AbovePosition30,AbovePosition31,AbovePosition32,AbovePosition33,AbovePosition34,AbovePosition35,AbovePosition36,AbovePosition37,AbovePosition38,AbovePosition39,AbovePosition40,AbovePosition41,AbovePosition42,AbovePosition43,AbovePosition44,AbovePosition45,AbovePosition46,AbovePosition47,AbovePosition48,AbovePosition49,AbovePosition50,WinnerAbovePos,WinnerAbovePos,WinnerAbovePos,WinnerAbovePos,WinnerAbovePos,WinnerAbovePos,WinnerAbovePos,WinnerAbovePos,WinnerAbovePos];

    !VAR NUM Myarray{8};

    !**************************************************************************
    !TOOL DATA
    !**************************************************************************
    TASK PERS tooldata myPencilTCP:=[TRUE,[[0,0,306],[1,0,0,0]],[1,[0,0,1],[1,0,0,0],0,0,0]];
    TASK PERS tooldata ServoGripperTCP:=[TRUE,[[0,0,160],[1,0,0,0]],[1,[0,0,1],[1,0,0,0],0,0,0]];

    !**************************************************************************
    !WORKOBJECT DATA
    !**************************************************************************
    TASK PERS wobjdata Board:=[FALSE,TRUE,"",[[762.964,-272.585,68.7058],[0.698603,-0.00316133,-0.00101552,0.715502]],[[0,0,0],[1,0,0,0]]];

    !**************************************************************************
    !VALUES AND VARIABLES
    !**************************************************************************

    !VAR num Dice;
    PERS num CurrentPositionP1;
    PERS num CurrentPositionP2;
    VAR num DiceNumberP1;
    VAR num DiceNumberP2;
    VAR num OverlapNumP1;
    VAR num OverlapNumP2;
    PERS string Status;
 !   VAR string TempString;
    PERS num WonStatus;

    PROC Main()

        !SET ALL PositionS TO ZERO
        CurrentPositionP1:=0;
        CurrentPositionP2:=0;
        Status:=" ";
        WonStatus:=0;

        CamSet;

        SetDO DO10_2_StackAmber,0;
        SetDo DO10_1_StackGreen,0;

        Gameplay;


    ENDPROC



    PROC Gameplay()

        OldAbovePickPosP1:=AbovePosition00;
        OldPickPosP1:=Position00;
        OldAbovePickPosP2:=AbovePosition00;
        OldPickPosP2:=Position00;

        Player1Start;

        WHILE CurrentPositionP1<50 OR CurrentPositionP2<50 DO

            !*****************************************************
            !Player 1
            !*****************************************************

            Repeat1:

            SetDO DO10_2_StackAmber,1;

            MoveToDetectedObject;

            IF DiceValue=6 THEN

                OverlapNumP1:=DiceValue;

                IF CurrentPositionP2=CurrentPositionP1+OverlapNumP1 THEN

                    Status:="Pawns Overlap, Play again";

                    GOTO Repeat1;

                ENDIF

                DiceNumberP1:=DiceValue;

                CalculationsP1;

                GOTO Repeat1;

            ENDIF

            OverlapNumP1:=DiceValue;

            IF CurrentPositionP2=CurrentPositionP1+OverlapNumP1 THEN

                Status:="Pawns Overlap, Play again";


                GOTO Repeat1;

            ENDIF

            DiceNumberP1:=DiceValue;

            CalculationsP1;

            SetDO DO10_2_StackAmber,0;


            !*****************************************************
            !Player Robot
            !*****************************************************

            Repeat2:

            SetDo DO10_1_StackGreen,1;

            MoveToDetectedObject;

            IF CurrentPositionP2=0 THEN

                Player2Start;

            ENDIF

            IF DiceValue=6 THEN

                OverlapNumP2:=DiceValue;

                IF CurrentPositionP1=CurrentPositionP2+OverlapNumP2 THEN

                    Status:="Pawns Overlap, Play again";

                    GOTO Repeat2;

                ENDIF

                DiceNumberP2:=DiceValue;

                calculationsP2;

                GOTO Repeat2;

            ENDIF

            OverlapNumP2:=DiceValue;

            IF CurrentPositionP1=CurrentPositionP2+OverlapNumP2 THEN

                Status:="Pawns Overlap, Play again";

                GOTO Repeat2;

            ENDIF

            DiceNumberP2:=DiceValue;

            calculationsP2;

            SetDo DO10_1_StackGreen,0;

        ENDWHILE

        EXIT;

    ENDPROC

    PROC CalculationsP1()

        IF CurrentPositionP1=0 THEN
            OldPickPosp1:=Position00;
            OldAbovePickPosP1:=AbovePosition00;
        ELSE
            OldPickPosP1:=PickPositions{CurrentPositionP1+1};
            OldAbovePickPosP1:=AbovePickPositions{CurrentPositionP1+1};

        ENDIF

        CurrentPositionP1:=CurrentPositionP1+DiceNumberP1;

        Winner;

        SnakeProcedure;

        LadderProcedure;

        CurrentPickPosP1:=PickPositions{CurrentPositionP1+1};
        CurrentAbovePickPosP1:=AbovePickPositions{CurrentPositionP1+1};

        MovementP1;

    ENDPROC


    PROC CalculationsP2()

        IF CurrentPositionP2=0 THEN
            OldPickPosp2:=Position00;
            OldAbovePickPosP2:=AbovePosition00;
        ELSE

            OldPickPosP2:=PickPositions{CurrentPositionP2+1};
            OldAbovePickPosP2:=AbovePickPositions{CurrentPositionP2+1};

        ENDIF

        CurrentPositionP2:=CurrentPositionP2+DiceNumberP2;

        Winner;

        SnakeProcedure;

        LadderProcedure;

        CurrentPickPosP2:=PickPositions{CurrentPositionP2+1};
        CurrentAbovePickPosP2:=AbovePickPositions{CurrentPositionP2+1};

        MovementP2;

    ENDPROC

    PROC MovementP1()

        MoveJ OldAbovePickPosP1,v500,fine,ServoGripperTCP\WObj:=Board;
        MoveL OldPickPosP1,v150,fine,ServoGripperTCP\WObj:=Board;

        GripperClosePawn;

        MoveL OldAbovePickPosP1,v150,fine,ServoGripperTCP\WObj:=Board;

        MoveL CurrentAbovePickPosP1,v500,fine,ServoGripperTCP\WObj:=Board;
        MoveL CurrentPickPosP1,v150,fine,ServoGripperTCP\WObj:=Board;

        GripperOpenPawn;

        MoveJ CurrentAbovePickPosP1,v500,z10,ServoGripperTCP\WObj:=Board;

    ENDPROC

    PROC MovementP2()

        MoveJ OldAbovePickPosP2,v500,fine,ServoGripperTCP\WObj:=Board;
        MoveL OldPickPosP2,v150,fine,ServoGripperTCP\WObj:=Board;

        GripperClosePawn;

        MoveL OldAbovePickPosP2,v150,fine,ServoGripperTCP\WObj:=Board;

        MoveL CurrentAbovePickPosP2,v500,fine,ServoGripperTCP\WObj:=Board;
        MoveL CurrentPickPosP2,v150,fine,ServoGripperTCP\WObj:=Board;

        GripperOpenPawn;

        MoveJ CurrentAbovePickPosP2,v500,z10,ServoGripperTCP\WObj:=Board;


    ENDPROC

    PROC Player1Start()

        MoveJ AbovePlayer1StartPos,v500,fine,ServoGripperTCP\WObj:=Board;
        MoveL Player1StartPos,v150,fine,ServoGripperTCP\WObj:=Board;

        GripperClosePawn;

        MoveL AbovePlayer1StartPos,v150,fine,ServoGripperTCP\WObj:=Board;

        MoveL AbovePosition00,v500,fine,ServoGripperTCP\WObj:=Board;
        MoveL Position00,v150,fine,ServoGripperTCP\WObj:=Board;

        GripperOpenPawn;

        MoveJ AbovePosition00,v500,fine,ServoGripperTCP\WObj:=Board;


    ENDPROC

    PROC Player2Start()

        MoveJ AbovePlayer2StartPos,v500,fine,ServoGripperTCP\WObj:=Board;
        MoveL Player2StartPos,v150,fine,ServoGripperTCP\WObj:=Board;

        GripperClosePawn;

        MoveL AbovePlayer2StartPos,v150,fine,ServoGripperTCP\WObj:=Board;

        MoveL AbovePosition00,v500,fine,ServoGripperTCP\WObj:=Board;
        MoveL Position00,v150,fine,ServoGripperTCP\WObj:=Board;

        GripperOpenPawn;

        MoveL AbovePosition00,v500,fine,ServoGripperTCP\WObj:=Board;


    ENDPROC

    PROC SnakeProcedure()


        IF CurrentPositionP1=14 AND CurrentPositionP2=4 THEN
            CurrentPositionP1:=5;

        ELSEIF CurrentPositionP1=14 AND CurrentPositionP2<>4 THEN
            CurrentPositionP1:=4;
            Status:="Oops Snake ate Player 1, Go to Position 4";

        ELSEIF CurrentPositionP1=22 AND CurrentPositionP2=16 THEN
            CurrentPositionP1:=17;
            Status:="Oops Snake ate Player 1, Go to 17";

        ELSEIF CurrentPositionP1=22 AND CurrentPositionP2<>16 THEN
            CurrentPositionP1:=16;
            Status:="Oops Snake ate Player 1, Go to 16";

        ELSEIF CurrentPositionP1=26 AND CurrentPositionP2=9 THEN
            CurrentPositionP1:=10;
            Status:="Oops Snake ate Player 1, Go to 10";

        ELSEIF CurrentPositionP1=26 AND CurrentPositionP2<>9 THEN
            CurrentPositionP1:=9;
            Status:="Oops Snake ate Player 1, Go to 9";

        ELSEIF CurrentPositionP1=32 AND CurrentPositionP2=6 THEN
            CurrentPositionP1:=7;
            Status:="Oops Snake ate Player 1, Go to 7";

        ELSEIF CurrentPositionP1=32 AND CurrentPositionP2<>6 THEN
            CurrentPositionP1:=6;
            Status:="Oops Snake ate Player 1, Go to 6";

        ELSEIF CurrentPositionP1=34 AND CurrentPositionP2=20 THEN
            CurrentPositionP1:=21;
            Status:="Oops Snake ate Player 1, Go to 21";

        ELSEIF CurrentPositionP1=34 AND CurrentPositionP2<>20 THEN
            CurrentPositionP1:=20;
            Status:="Oops Snake ate Player 1, Go to 20";

        ELSEIF CurrentPositionP1=43 AND CurrentPositionP2=30 THEN
            CurrentPositionP1:=31;
            Status:="Oops Snake ate Player 1, Go to 31";

        ELSEIF CurrentPositionP1=43 AND CurrentPositionP2<>30 THEN
            CurrentPositionP1:=30;
            Status:="Oops Snake ate Player 1, Go to 30";


            !Player2

        ELSEIF CurrentPositionP2=14 AND CurrentPositionP1=4 THEN
            CurrentPositionP2:=5;
            Status:="Oops Snake ate the Robot, Robot goes to 5";

        ELSEIF CurrentPositionP2=14 AND CurrentPositionP1<>4 THEN
            CurrentPositionP2:=4;
            Status:="Oops Snake ate the Robot, Robot goes to 4";

        ELSEIF CurrentPositionP2=22 AND CurrentPositionP1=16 THEN
            CurrentPositionP2:=17;
            Status:="Oops Snake ate the Robot, Robot goes to 17";

        ELSEIF CurrentPositionP2=22 AND CurrentPositionP1<>16 THEN
            CurrentPositionP2:=16;
            Status:="Oops Snake ate the Robot, Robot goes to 16";

        ELSEIF CurrentPositionP2=26 AND CurrentPositionP1=9 THEN
            CurrentPositionP2:=10;
            Status:="Oops Snake ate the Robot, Robot goes to 10";

        ELSEIF CurrentPositionP2=26 AND CurrentPositionP1<>9 THEN
            CurrentPositionP2:=9;
            Status:="Oops Snake ate the Robot, Robot goes to 9";

        ELSEIF CurrentPositionP2=32 AND CurrentPositionP1=6 THEN
            CurrentPositionP2:=7;
            Status:="Oops Snake ate the Robot, Robot goes to 7";

        ELSEIF CurrentPositionP2=32 AND CurrentPositionP1<>6 THEN
            CurrentPositionP2:=6;
            Status:="Oops Snake ate the Robot, Robot goes to 6";

        ELSEIF CurrentPositionP2=34 AND CurrentPositionP1=20 THEN
            CurrentPositionP2:=21;
            Status:="Oops Snake ate the Robot, Robot goes to 21";

        ELSEIF CurrentPositionP2=34 AND CurrentPositionP1<>20 THEN
            CurrentPositionP2:=20;
            Status:="Oops Snake ate the Robot, Robot goes to 20";

        ELSEIF CurrentPositionP2=43 AND CurrentPositionP1=30 THEN
            CurrentPositionP2:=31;
            Status:="Oops Snake ate the Robot, Robot goes to 31";

        ELSEIF CurrentPositionP2=43 AND CurrentPositionP1<>30 THEN
            CurrentPositionP2:=30;
            Status:="Oops Snake ate the Robot, Robot goes to 30";

        ENDIF

    ENDPROC


    PROC LadderProcedure()


        IF CurrentPositionP1=1 AND CurrentPositionP2=17 THEN
            CurrentPositionP1:=18;
            Status:="Awesome!, Player 1 Climbs to 18";

        ELSEIF CurrentPositionP1=1 AND CurrentPositionP2<>17 THEN
            CurrentPositionP1:=17;
            Status:="Awesome!, Player 1 Climbs to 17";

        ELSEIF CurrentPositionP1=3 AND CurrentPositionP2=21 THEN
            CurrentPositionP1:=23;
            Status:="Awesome!, Player 1 Climbs to 23";

        ELSEIF CurrentPositionP1=3 AND CurrentPositionP2<>21 THEN
            CurrentPositionP1:=21;
            Status:="Awesome!, Player 1 Climbs to 21";

        ELSEIF CurrentPositionP1=12 AND CurrentPositionP2=25 THEN
            CurrentPositionP1:=27;
            Status:="Awesome!, Player 1 Climbs to 27";

        ELSEIF CurrentPositionP1=12 AND CurrentPositionP2<>25 THEN
            CurrentPositionP1:=25;
            Status:="Awesome!, Player 1 Climbs to 25";

        ELSEIF CurrentPositionP1=18 AND CurrentPositionP2=36 THEN
            CurrentPositionP1:=37;
            Status:="Awesome!, Player 1 Climbs to 37";

        ELSEIF CurrentPositionP1=18 AND CurrentPositionP2<>36 THEN
            CurrentPositionP1:=36;
            Status:="Awesome!, Player 1 Climbs to 36";

        ELSEIF CurrentPositionP1=29 AND CurrentPositionP2=45 THEN
            CurrentPositionP1:=46;
            Status:="Awesome!, Player 1 Climbs to 46";

        ELSEIF CurrentPositionP1=29 AND CurrentPositionP2<>45 THEN
            CurrentPositionP1:=45;
            Status:="Awesome!, Player 1 Climbs to 45";

        ELSEIF CurrentPositionP1=35 AND CurrentPositionP2=38 THEN
            CurrentPositionP1:=39;
            Status:="Awesome!, Player 1 Climbs to 39";

        ELSEIF CurrentPositionP1=35 AND CurrentPositionP2<>38 THEN
            CurrentPositionP1:=38;
            Status:="Awesome!, Player 1 Climbs to 38";

            !Player 2

        ELSEIF CurrentPositionP2=1 AND CurrentPositionP1=38 THEN
            CurrentPositionP2:=18;
            Status:="Robot climbs the ladder to 18";

        ELSEIF CurrentPositionP2=1 AND CurrentPositionP1<>38 THEN
            CurrentPositionP2:=17;
            Status:="Robot climbs the ladder to 17";

        ELSEIF CurrentPositionP2=3 AND CurrentPositionP1=21 THEN
            CurrentPositionP2:=23;
            Status:="Robot climbs the ladder to 23";

        ELSEIF CurrentPositionP2=3 AND CurrentPositionP1<>21 THEN
            CurrentPositionP2:=21;
            Status:="Robot climbs the ladder to 21";

        ELSEIF CurrentPositionP2=12 AND CurrentPositionP1=25 THEN
            CurrentPositionP2:=27;
            Status:="Robot climbs the ladder to 27";

        ELSEIF CurrentPositionP2=12 AND CurrentPositionP1<>25 THEN
            CurrentPositionP2:=25;
            Status:="Robot climbs the ladder to 25";

        ELSEIF CurrentPositionP2=18 AND CurrentPositionP1=36 THEN
            CurrentPositionP2:=37;
            Status:="Robot climbs the ladder to 37";

        ELSEIF CurrentPositionP2=18 AND CurrentPositionP1<>36 THEN
            CurrentPositionP2:=36;
            Status:="Robot climbs the ladder to 36";

        ELSEIF CurrentPositionP2=29 AND CurrentPositionP1=45 THEN
            CurrentPositionP2:=46;
            Status:="Robot climbs the ladder to 46";

        ELSEIF CurrentPositionP2=29 AND CurrentPositionP1<>45 THEN
            CurrentPositionP2:=45;
            Status:="Robot climbs the ladder to 45";

        ELSEIF CurrentPositionP2=35 AND CurrentPositionP1=38 THEN
            CurrentPositionP2:=39;
            Status:="Robot climbs the ladder to 39";

        ELSEIF CurrentPositionP2=35 AND CurrentPositionP1<>38 THEN
            CurrentPositionP2:=38;
            Status:="Robot climbs the ladder to 38";

        ENDIF

    ENDPROC

    PROC Winner()

        IF CurrentPositionP1>50 THEN

            Status:="PLAYER 1 WON";

            MoveJ OldAbovePickPosP1,v500,fine,ServoGripperTCP\WObj:=Board;
            MoveL OldPickPosP1,v100,fine,ServoGripperTCP\WObj:=Board;

            GripperClosePawn;

            MoveL OldAbovePickPosP1,v100,fine,ServoGripperTCP\WObj:=Board;

            MoveL WinnerAbovePos,v500,fine,ServoGripperTCP\WObj:=Board;
            MoveL WinnerPos,v100,fine,ServoGripperTCP\WObj:=Board;

            GripperOpen;

            MoveJ WinnerAbovePos,v100,z10,ServoGripperTCP\WObj:=Board;

            WonStatus:=1;

            EXIT;

        ELSEIF CurrentPositionP2>50 THEN

            Status:="Robot Won the Game";

            MoveJ OldAbovePickPosP2,v500,fine,ServoGripperTCP\WObj:=Board;
            MoveL OldPickPosP2,v100,fine,ServoGripperTCP\WObj:=Board;

            GripperClosePawn;

            MoveL OldAbovePickPosP2,v100,fine,ServoGripperTCP\WObj:=Board;

            MoveL WinnerAbovePos,v500,fine,ServoGripperTCP\WObj:=Board;
            MoveL WinnerPos,v100,fine,ServoGripperTCP\WObj:=Board;

            GripperOpen;

            MoveJ WinnerAbovePos,v100,z10,ServoGripperTCP\WObj:=Board;

            WonStatus:=2;

            EXIT;

        ENDIF
    ENDPROC

ENDMODULE