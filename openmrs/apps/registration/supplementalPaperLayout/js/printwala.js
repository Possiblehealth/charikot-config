
try {
    var todayDate = $("#todayDate").text()
    splitedAD = todayDate.split("/");

    // alert(splitedAD[2])
    adYear = parseInt(splitedAD[2])
    adMonth =parseInt(splitedAD[1])
    adDate = parseInt(splitedAD[0])

    convertedDate = calendarFunctions.getBsDateByAdDate(adYear, adMonth, adDate)

    var now = new Date();

    bsDate = convertedDate.bsYear + "-" + convertedDate.bsMonth + "-" + convertedDate.bsDate +" "+now.getHours() +":"+now.getMinutes();
    // alert(bsDate)
    $("#todayDate").text(bsDate)


    var todayDate = $("#regDate").text()
    splitedAD1 = todayDate.split("/");

    // alert(splitedAD[2])
    adYear1 = parseInt(splitedAD1[2])
    adMonth1 =parseInt(splitedAD1[1])
    adDate1 = parseInt(splitedAD1[0])

    convertedDate1 = calendarFunctions.getBsDateByAdDate(adYear1, adMonth1, adDate1)
    bsDate1 = convertedDate1.bsYear + "-" + convertedDate1.bsMonth + "-" + convertedDate1.bsDate
    $("#regDate").text(bsDate1)
}
catch (err) {
    // alert(err)
    console.log("invalid date")
}
