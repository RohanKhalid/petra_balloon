class Ticket {
  final int ticketNumber;
  final String passenger;
  final String date;
  Ticket(this.ticketNumber, this.passenger, this.date);

  // named constructor
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(json['ticketNumber'] as int, json['Passenger'] as String,
        json['Date'] as String);
  }

  // method
  Map<String, dynamic> toJson() {
    return {'ticketNumber': ticketNumber, 'Passenger': passenger, 'Date': date};
  }
}
