require_relative '../config/sequel'
module ExpenseTracker
    RecordResult = Struct.new(:success?, :expense_id, :error_message)
    class Ledger
        def record(expense) # ??? how do i know it is taking expense as an argument. The test doesn't have record take expense argument 
            unless expense.key?('payee')
                message = 'Invalid expense: `payee` is required'
                return RecordResult.new(false, nil, message)
            end
             DB[:expenses].insert(expense)
             id = DB[:expenses].max(:id)
             RecordResult.new(true, id, nil)
        end
        def expenses_on(date)
            DB[:expenses].where(date: date).all
        end
    end
end