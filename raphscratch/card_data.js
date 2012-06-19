function CardData(data){
	
	//count the number of entries, that were created on Option
	var cardData = this;
	data.forEach(function(e, index, arr){
		var raisedOn = moment(e["In Backlog"], "DD/MM/YYYY");
		var month = raisedOn.month();
		var year = raisedOn.year();
		var cardType = e["Type"];
		
		if(cardData[year] == undefined) cardData[year] = new Object();
		if(cardData[year][month] == undefined) cardData[year][month] = new Object();
		if(cardData[year][month][cardType] == undefined) cardData[year][month][cardType] = 0;

		cardData[raisedOn.year()][month][cardType] ++;


	});
	

	
}



CardData.prototype.countFor = function (year, month, cardType){
	if(this[year][month] == undefined) return 0;
	if(this[year][month][cardType] == undefined) return 0;
	 return this[year][month][cardType];
}