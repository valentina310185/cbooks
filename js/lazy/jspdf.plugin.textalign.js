(function(API){
    API.textCenter = function(htmltext, y) {
		var fontSize = this.internal.getFontSize();
        var pageWidth = this.internal.pageSize.width;
        var txtWidth = this.getStringUnitWidth(htmltext)*fontSize/this.internal.scaleFactor;
        var x = ( pageWidth - txtWidth ) / 2;
        this.text(htmltext,x,y);
	};
	API.textRight = function(htmltext, y) {
		var fontSize = this.internal.getFontSize();
        var pageWidth = this.internal.pageSize.width;
        var txtWidth = this.getStringUnitWidth(htmltext)*fontSize/this.internal.scaleFactor;
        var x = ( pageWidth - txtWidth );
        this.text(htmltext,x,y);
	};
})(jsPDF.API);