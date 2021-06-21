pageextension 50120 "Customer Card Extn." extends "Customer Card"
{
    layout
    {
        addbefore(General)
        {
            usercontrol(MT; "Marquee Tag")
            {
                ApplicationArea = All;
            }
        }
        // addafter(General)
        // {
        //     part(WB; Workbench)
        //     {
        //         ApplicationArea = all;
        //     }
        // }
        // addafter("Address & Contact")
        // {
        //     group("Google Maps")
        //     {
        //         usercontrol(GM; "Google Maps")
        //         {
        //             ApplicationArea = All;
        //             trigger GoogleMapsReady()
        //             begin
        //             end;
        //         }
        //     }
        // }
    }
    actions
    {
        addfirst("&Customer")
        {
            group("&Help")
            {
                Caption = 'Help';

                action("videos")
                {
                    Caption = 'Youtube Video';
                    Promoted = true;
                    trigger OnAction()
                    begin
                        Page.RunModal(page::Youtube);
                    end;
                }



            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        updateMarqueeTag(Rec);
        //updateGoogleMap(Rec);
    end;

    procedure updateMarqueeTag(Rec: Record Customer)
    var
        _salesOrder: Record "Sales Header";
        _resultText: Text;
        _open: Integer;
        _pendingApproval: Integer;
        _pendingRepayment: Integer;
    begin
        _salesOrder.SetRange("Sell-to Customer No.", Rec."No.");
        _salesOrder.SetRange(Status, _salesOrder.Status::Open);
        if _salesOrder.FindSet() then
            _open := _salesOrder.Count;

        Clear(_salesOrder);
        _salesOrder.SetRange("Sell-to Customer No.", Rec."No.");
        _salesOrder.SetRange(Status, _salesOrder.Status::"Pending Approval");
        if _salesOrder.FindSet() then
            _pendingApproval := _salesOrder.Count;

        Clear(_salesOrder);
        _salesOrder.SetRange("Sell-to Customer No.", Rec."No.");
        _salesOrder.SetRange(Status, _salesOrder.Status::"Pending Prepayment");
        if _salesOrder.FindSet() then
            _pendingApproval := _salesOrder.Count;

        _resultText := Rec.Name + ' has: ';
        if _open <> 0 then
            _resultText := _resultText + StrSubstNo('%1 Sales Order - Open', _open);

        if _pendingApproval <> 0 then
            _resultText := _resultText + StrSubstNo(', %1 Sales Order - Pending for Approval', _pendingApproval);

        if _pendingRepayment <> 0 then
            _resultText := _resultText + StrSubstNo(', %1 Sales Order - Pending for Repayment', _pendingRepayment);

        if (_open = 0) and (_pendingApproval = 0) and (_pendingRepayment = 0) then
            _resultText := _resultText + 'No Open/Pending Approval or Pending Repayment Sales Order';

        CurrPage.MT.UpdateMarqueeTag(_resultText);
    end;

    // procedure updateGoogleMap(Rec: Record Customer)
    // var
    // begin
    //     CurrPage.GM.LoadGoogleMap(Rec.Address + ' ' + Rec."Address 2" + ' ' + Rec.City + ' ' + Rec."Country/Region Code");
    // end;
}