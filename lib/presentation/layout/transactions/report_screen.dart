import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  TableRow tableRow(id,channel, date, time, type, payment, total){
    return TableRow(children: [
      Center(child: Text(id, style: const TextStyle(fontSize: 15.0),)),
      Center(child: Text(channel, style: const TextStyle(fontSize: 15.0),)),
      Center(child: Text(date, style: const TextStyle(fontSize: 15.0),)),
      Center(child: Text(time, style: const TextStyle(fontSize: 15.0),)),
      Center(child: Text(type, style: const TextStyle(fontSize: 15.0),)),
      Center(child: Text(payment, style: const TextStyle(fontSize: 15.0),)),
      Center(child: Text(total, style: const TextStyle(fontSize: 15.0),)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_circle_left_rounded,
                    size: 30,
                  )),
              Text(
                'Report',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.summarize_rounded),
                      Text('Print'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Card(
            elevation: 0,
            color: Colors.grey.withOpacity(0.4),child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Summary',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:   [
                        Row(
                          children: const [
                            Text('from',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                            SizedBox(width: 10,),
                            Text('December, 7,2022',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 20),),
                            SizedBox(width: 10,),
                            Text('20 : 15 : 00',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                          ],
                        ),
                        Row(
                          children: const [
                            Text('to',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                            SizedBox(width: 10,),
                            Text('December, 7,2022',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 20),),
                            SizedBox(width: 10,),
                            Text('20 : 15 : 00',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 0,
                      color: Colors.grey.withOpacity(0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: const [
                          Text('Cash',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 40),),
                          Text('2000\$',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30),),
                        ],),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: Colors.grey.withOpacity(0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: const [
                          Text('Card',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 40),),
                          Text('2000\$',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30),),
                        ],),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: Colors.grey.withOpacity(0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: const [
                          Text('Total',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 40),),
                          Text('4000\$',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30),),
                        ],),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),),

          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Transactions List',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Table(
                      border: TableBorder.all(color: Colors.black,width: 1,borderRadius: const BorderRadius.all(Radius.circular(5))),
                      columnWidths: const {
                        0: FixedColumnWidth(100),
                        1: FlexColumnWidth(),
                        2: FixedColumnWidth(150),
                        3: FixedColumnWidth(150),
                        4: FixedColumnWidth(150),
                        5: FixedColumnWidth(150),
                        6: FixedColumnWidth(150),
                        7: FixedColumnWidth(150),
                      },
                      children: [
                        TableRow(
                            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                            children: const [
                              Center(child: Text('ID',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),)),
                              Center(child: Text('Channel',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),)),
                              Center(child: Text('Date',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),)),
                              Center(child: Text('Time',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),)),
                              Center(child: Text('Type',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),)),
                              Center(child: Text('Payment',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),)),
                              Center(child: Text('Total',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),)),

                            ]),

                        tableRow('1','ahmed khaled', '25-06-2000','25:25:00', 'OUT', 'Card','200\$'),
                        tableRow('1','ahmed khaled', '25-06-2000','25:25:00', 'OUT', 'Card','200\$'),
                        tableRow('1','ahmed khaled', '25-06-2000','25:25:00', 'OUT', 'Card','200\$'),
                        tableRow('1','ahmed khaled', '25-06-2000','25:25:00', 'OUT', 'Card','200\$'),
                        tableRow('1','ahmed khaled', '25-06-2000','25:25:00', 'OUT', 'Card','200\$'),
                        tableRow('1','ahmed khaled', '25-06-2000','25:25:00', 'OUT', 'Card','200\$'),
                        tableRow('1','ahmed khaled', '25-06-2000','25:25:00', 'OUT', 'Card','200\$'),
                        tableRow('1','ahmed khaled', '25-06-2000','25:25:00', 'OUT', 'Card','200\$'),
                        tableRow('1','ahmed khaled', '25-06-2000','25:25:00', 'OUT', 'Card','200\$'),
                        tableRow('1','ahmed khaled', '25-06-2000','25:25:00', 'OUT', 'Card','200\$'),



                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
