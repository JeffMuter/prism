package workers

import (
	"fmt"
	"prism/util"
)

type PrintableWorkerFactory interface {
	CreatePrintable(worker Worker) util.Printable
}

type workerState struct{ Worker }
type WorkerStateFactory struct{}

func (factory WorkerStateFactory) CreatePrintable(worker Worker) util.Printable {
	return workerState{worker}
}
func (worker workerState) StringToPrint() string {
	return fmt.Sprintf("%s | %s |", worker.Name, worker.WorkType)
}

func workerStateFactory(worker Worker) util.Printable {
	return workerState{Worker: worker}
}

func MakeWorkersPrintable(workers []Worker, factory PrintableWorkerFactory) []util.Printable {
	var prints []util.Printable
	for _, worker := range workers {
		print := factory.CreatePrintable(worker)
		prints = append(prints, print)
	}
	return prints
}
