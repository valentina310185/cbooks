(function(API){
    API.textCenter = function(text, y) {
		var fontSize = this.internal.getFontSize();
        var pageWidth = this.internal.pageSize.width;
        var txtWidth = this.getStringUnitWidth(text)*fontSize/this.internal.scaleFactor;
        var x = ( pageWidth - txtWidth ) / 2;
        this.text(text,x,y);
	};
	API.textRight = function(text, y) {
		var fontSize = this.internal.getFontSize();
        var pageWidth = this.internal.pageSize.width;
        var txtWidth = this.getStringUnitWidth(text)*fontSize/this.internal.scaleFactor;
        var x = ( pageWidth - txtWidth );
        this.text(text,x,y);
	};
})(jsPDF.API);