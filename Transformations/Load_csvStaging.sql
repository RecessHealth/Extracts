BULK INSERT staging.dbo.Demographics
    from 'C:\Users\jadrummond\Documents\deliverables\recess\extract\Barnabas\BigSquid\Demographics.csv'
    with (formatfile = 'C:\Users\jadrummond\Documents\deliverables\recess\extract\Barnabas\BigSquid\Demographics_format2.txt');
